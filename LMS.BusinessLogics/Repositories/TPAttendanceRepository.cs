using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class TPAttendanceRepository : ITPAttendanceRepository
    {
        private LmsDbContext _lmsDbContext;

        public TPAttendanceRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddSession(Session objSession)
        {
            try
            {
                await _lmsDbContext.Session.AddAsync(objSession);
                await _lmsDbContext.SaveChangesAsync();

                return 1;

            }
            catch (Exception ex)
            {
                // _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;

            }
        }

        public async Task<int> DeleteSession(int id)
        {
            try
            {
                var deleteSession = await GetSessionById(id);

                _lmsDbContext.Session.Remove(deleteSession);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }



        public async Task<Session> GetSessionById(int Id)
        {
            var Session = await _lmsDbContext.Session
                        .AsNoTracking()
                        .FirstOrDefaultAsync(s => s.Session_Id == Id);

            return Session;
        }


        public IQueryable<AttendanceViewModel> GetAllClassSectionByTeacherId(int TeacherId)
        {
            IQueryable<AttendanceViewModel> AllClassSection =
                                                                    (from t in _lmsDbContext.Teacher
                                                                     join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                     join cs in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals cs.ClassSubject_Id
                                                                     join csec in _lmsDbContext.ClassSection on cs.ClassSection_Id equals csec.ClassSection_id
                                                                     join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                                     join sec in _lmsDbContext.Section on csec.Section_Id equals sec.Section_Id
                                                                     where t.Teacher_Id == TeacherId
                                                                     orderby c.Class_Name, sec.Section_Name
                                                                     select new AttendanceViewModel
                                                                     {

                                                                         Class_Id = c.Class_Id,
                                                                         Class_Name = c.Class_Name,
                                                                         Section_Id = sec.Section_Id,
                                                                         Section_Name = sec.Section_Name,

                                                                     }).AsQueryable().Distinct();

            return AllClassSection;
        }


        public IQueryable<AttendanceViewModel> GetAllSessionByTeacherId(int TeacherId)
        {
            IQueryable<AttendanceViewModel> Session = (from sess in _lmsDbContext.Session
                                                       where
                                                         sess.Teacher_Id == TeacherId
                                                       select new AttendanceViewModel
                                                       {
                                                           Session_Id = sess.Session_Id,
                                                           Session_Name = sess.Session_Name,
                                                           Session_Date = DateTime.ParseExact(sess.Date, "yyyyMMdd", null),
                                                           Session_Start_Time = DateTime.ParseExact(sess.Start_Time,"HHmmss",null),
                                                           Session_End_Time = DateTime.ParseExact(sess.End_Time,"HHmmss",null),
                                                           Class_Id = sess.Class.Class_Id,
                                                           Class_Name = sess.Class.Class_Name,
                                                           Section_Id = sess.Section.Section_Id,
                                                           Section_Name = sess.Section.Section_Name,
                                                           Subject_Id = sess.Subject.Subject_Id,
                                                           Subject_Name = sess.Subject.Subject_Name,
                                                           Teacher_Id = sess.Teacher_Id

                                                       }).AsQueryable();

            return Session;
        }


        public IQueryable<AttendanceViewModel> GetAllSubjectByTeacherId(int TeacherId)
        {
            IQueryable<AttendanceViewModel> AllSubject =
                                                                    (from t in _lmsDbContext.Teacher
                                                                     join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                     join cs in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals cs.ClassSubject_Id
                                                                     join sub in _lmsDbContext.Subject on cs.Subject_Id equals sub.Subject_Id
                                                                     where t.Teacher_Id == TeacherId
                                                                     orderby sub.Subject_Name
                                                                     select new AttendanceViewModel
                                                                     {
                                                                     
                                                                         Subject_Id = sub.Subject_Id,
                                                                         Subject_Name = sub.Subject_Name,
                                                                     
                                                                     
                                                                     }).AsQueryable().Distinct();

            return AllSubject;
        }

        public async Task<int> UpdateSession(Session objSession)
        {
            try
            {
                _lmsDbContext.Session.Update(objSession);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<AttendanceViewModel> GetAllStudentsClass(int TeacherId)
        {
            IQueryable<AttendanceViewModel> StudentClass = (from tsub in _lmsDbContext.TeacherSubject
                                                            join sc in _lmsDbContext.StudentClass on new { ClassSection_Id = tsub.ClassSubject.ClassSection_Id } equals new { ClassSection_Id = sc.ClassSection_id }
                                                            where
                                                              tsub.Teacher.Teacher_Id == TeacherId
                                                            orderby
                                                              tsub.ClassSubject.ClassSection.Class.Class_Id,
                                                              tsub.ClassSubject.ClassSection.Section.Section_Id
                                                            select new AttendanceViewModel
                                                            {
                                                                Student_Id = sc.Student.Student_Id,
                                                                Student_Name = sc.Student.Student_Name,
                                                                Class_Id = tsub.ClassSubject.ClassSection.Class.Class_Id,
                                                                Class_Name = tsub.ClassSubject.ClassSection.Class.Class_Name,
                                                                Section_Id = tsub.ClassSubject.ClassSection.Section.Section_Id,
                                                                Section_Name = tsub.ClassSubject.ClassSection.Section.Section_Name,
                                                                Subject_Id = 0
                                                            }).Distinct().AsQueryable();

            return StudentClass;
        }

        public int AddAttendance(List<Attendance> objAttendance)
        {
            try
            {

                  _lmsDbContext.Attendance.AddRangeAsync(objAttendance);
                  _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<AttendanceViewModel> GetAttendanceByTeacherId(int TeacerId)
        {
            IQueryable<AttendanceViewModel> AttendanceDetail = (

                                                                 from atd in _lmsDbContext.Attendance
                                                                 join sess in _lmsDbContext.Session on atd.Session_Id equals sess.Session_Id
                                                                 where
                                                                   atd.Teacher_Id == TeacerId
                                                                 orderby
                                                                   atd.Class.Class_Id,
                                                                   atd.Section.Section_Id
                                                                 select new AttendanceViewModel
                                                                 {
                                                                     Attendance_Id = atd.Attendance_Id,
                                                                     Session_Id =sess.Session_Id,
                                                                     Session_Name = sess.Session_Name,
                                                                     Student_Id = atd.Student_Id,
                                                                     Student_Name = atd.Student_Name,
                                                                     Class_Id = atd.Class_Id,
                                                                     Class_Name = atd.Class.Class_Name,
                                                                     Section_Id = atd.Section_Id,
                                                                     Section_Name = atd.Section.Section_Name,
                                                                     Subject_Id = atd.Session.Subject_Id,
                                                                     Subject_Name = atd.Session.Subject.Subject_Name,
                                                                     Session_Date = DateTime.ParseExact(atd.Date, "yyyyMMd", null),
                                                                     Status = atd.Status
                                                                 }).AsQueryable();

            return AttendanceDetail;
        }

        public async Task<Attendance> GetAttendanceById(int AttendanceId)
        {
            var Attendance = await _lmsDbContext.Attendance
                        .AsNoTracking()
                        .FirstOrDefaultAsync(a => a.Attendance_Id == AttendanceId);

            return Attendance;
        }

        public async Task<int> UpdateAttendance(Attendance objAttendance)
        {
            try
            {
                _lmsDbContext.Attendance.Update(objAttendance);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> DeleteAttendance(int Attendance_Id)
        {
            try
            {
                var deleteAttendance = await GetAttendanceById(Attendance_Id);

                _lmsDbContext.Attendance.Remove(deleteAttendance);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }
}
