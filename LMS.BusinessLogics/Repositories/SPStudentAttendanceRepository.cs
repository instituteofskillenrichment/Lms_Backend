using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace LMS.BusinessLogics.Repositories
{
    public class SPStudentAttendanceRepository : ISPStudentAttendanceRepository
    {
        private LmsDbContext _lmsDbContext;

        public SPStudentAttendanceRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<IEnumerable<StudentAttendanceViewModel>> GetAllAttendance(int Student_Id)
        {
            var listOfAttendance = await(
                                            from s in _lmsDbContext.Student
                                            join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                            join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                            join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                            join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id
                                            join csub in _lmsDbContext.ClassSubject on cs.ClassSection_id equals csub.ClassSection_Id
                                            join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                            join sess in _lmsDbContext.Session on csub.Subject_Id equals sess.Subject_Id
                                            join a in _lmsDbContext.Attendance on sess.Session_Id equals a.Session_Id
                                            where
                                                s.Student_Id == Student_Id
                                                && sess.Subject_Id == sub.Subject_Id
                                                && sess.Class_Id == cs.Class_Id
                                                && sess.Section_Id == cs.Section_Id
                                                && a.Class_Id == sess.Class_Id
                                                && a.Section_Id == sess.Section_Id
                                            orderby sess.Date descending
                                            select new StudentAttendanceViewModel
                                            {
                                                Student_Id = s.Student_Id,
                                                Student_Name = s.Student_Name,
                                                Class_Id = csub.ClassSection.Class.Class_Id,
                                                Class_Name = csub.ClassSection.Class.Class_Name,
                                                Section_Id = csub.ClassSection.Section.Section_Id,
                                                Section_Name = csub.ClassSection.Section.Section_Name,
                                                Subject_Id = csub.Subject.Subject_Id,
                                                Subject_Name = csub.Subject.Subject_Name,
                                                Session_Name = sess.Session_Name,
                                                Session_Date = DateTime.ParseExact(sess.Date, "yyyyMMdd", null),
                                                Attendance_Status = a.Status,
                                                Attendance_Date = DateTime.ParseExact(a.Date, "yyyyMMdd", null),

                                            }
                                       ).ToListAsync();

            return listOfAttendance;
        }
    }
}
