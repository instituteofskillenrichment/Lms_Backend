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
    public class LectureRepository : ILectureRepository
    {
        private LmsDbContext _lmsDbContext;

        public LectureRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }



        public async Task<int> AddLecture(Lecture objLecture)
        {
            try
            {
                await _lmsDbContext.Lecture.AddAsync(objLecture);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public async Task<int> DeleteLecture(int id)
        {
            try
            {
                var deleteLecture = await GetLectureById(id);



                _lmsDbContext.Lecture.Remove(deleteLecture);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public async Task<IEnumerable<Lecture>> GetAllLecture(int TeachiId)
        {
            var listOfLecture = await _lmsDbContext.Lecture
                                .AsNoTracking()
                                .Where(l => l.Teacher_Id == TeachiId).ToListAsync(); ;

            return listOfLecture;
        }



        public async Task<Lecture> GetLectureById(int Id)
        {
            var Lecture = await _lmsDbContext.Lecture
                       .AsNoTracking()
                       .FirstOrDefaultAsync(c => c.Lecture_Id == Id);
            

            return Lecture;
        }



        public async Task<int> UpdateLecture(Lecture objLecture)
        {
            try
            {
                _lmsDbContext.Lecture.Update(objLecture);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public async Task<IEnumerable<Lecture>> GetLectureBySubject(int Id)
        {
            var Lecture = await _lmsDbContext.Lecture
                       .AsNoTracking()
                       .Where(c => c.ClassSubject_Id == Id).ToListAsync();

            return Lecture;
        }



        public IQueryable<Class> GetAllClass()
        {
            IQueryable<Class> listOfClass = _lmsDbContext.Class.AsQueryable();

            return listOfClass;
        }


        public IQueryable<Section> GetAllSection()
        {
            IQueryable<Section> listOfClass = _lmsDbContext.Section.AsQueryable();

            return listOfClass;
        }


        public IQueryable<Subject> GetAllSubject()
        {
            IQueryable<Subject> listOfSubject = _lmsDbContext.Subject.OrderBy(e => e.Subject_Id).AsQueryable();

            return listOfSubject;
        }

        public IQueryable<LectureViewModel> GetAllClassSectionByTeacherId(int TeacherId)
        {
            IQueryable<LectureViewModel> AllClassSection =
                                                                    (from t in _lmsDbContext.Teacher
                                                                     join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                     join cs in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals cs.ClassSubject_Id
                                                                     join csec in _lmsDbContext.ClassSection on cs.ClassSection_Id equals csec.ClassSection_id
                                                                     join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                                     join sec in _lmsDbContext.Section on csec.Section_Id equals sec.Section_Id
                                                                     where t.Teacher_Id == TeacherId
                                                                     orderby c.Class_Name, sec.Section_Name
                                                                     select new LectureViewModel
                                                                     {

                                                                         Class_Id = c.Class_Id,
                                                                         Class_Name = c.Class_Name,
                                                                         Section_Id = sec.Section_Id,
                                                                         Section_Name = sec.Section_Name,

                                                                     }).AsQueryable().Distinct();

            return AllClassSection;
        }

        public IQueryable<LectureViewModel> GetAllSubjectByTeacherId(int TeacherId)
        {
            IQueryable<LectureViewModel> AllSubject =
                                                                    (from t in _lmsDbContext.Teacher
                                                                     join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                     join cs in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals cs.ClassSubject_Id
                                                                     join sub in _lmsDbContext.Subject on cs.Subject_Id equals sub.Subject_Id
                                                                     where t.Teacher_Id == TeacherId
                                                                     orderby sub.Subject_Name
                                                                     select new LectureViewModel
                                                                     {

                                                                         Subject_Id = sub.Subject_Id,
                                                                         Subject_Name = sub.Subject_Name,


                                                                     }).AsQueryable().Distinct();

            return AllSubject;
        }

    }
}
