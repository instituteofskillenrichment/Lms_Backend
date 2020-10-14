using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
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



        public IQueryable<Lecture> GetAllLecture()
        {
            IQueryable<Lecture> listOfLecture = _lmsDbContext.Lecture.AsQueryable();

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
    }
}
