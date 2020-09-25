using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading.Tasks;


namespace LMS.BusinessLogics.Repositories
{
    public class TeacherRepository : ITeacherRepository
    {
        private LmsDbContext _lmsDbContext;

        private ILogger<TeacherRepository> _logger;

        public TeacherRepository(LmsDbContext lmsDbContext, ILogger<TeacherRepository> logger)
        {
            _lmsDbContext = lmsDbContext;
            _logger = logger;

        

        }

        public async Task<int> AddTeacher(Teacher objTeacher)
        {

            try
            {
                await _lmsDbContext.Teacher.AddAsync(objTeacher);

                int TeacherId = objTeacher.Teacher_Id;
                //await _lmsDbContext.SaveChangesAsync();
                return TeacherId;
            }
            catch (System.Exception ex)
            {
                _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }

        }

        public async Task<int> DeleteTeacher(int id)
        {
            try
            {
                var deleteTeacher = await GetTeacherById(id);

                _lmsDbContext.Teacher.Remove(deleteTeacher);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (System.Exception ex)
            {
                _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }
        }

        public IQueryable<Teacher> GetAllTeacher()
        {
            IQueryable<Teacher> listOfTeacher = _lmsDbContext.Teacher.AsQueryable();

            return listOfTeacher;
        }

        public async Task<Teacher> GetTeacherById(int Id)
        {
            var Teacher = await _lmsDbContext.Teacher
                        .AsNoTracking()
                        .FirstOrDefaultAsync(c => c.Teacher_Id == Id);

            return Teacher;
        }
        public Teacher FindTeacherById(int Id)
        {
            Teacher Teacher =   _lmsDbContext.Teacher.Find(Id);
                        

            return Teacher;
        }

        public async Task<int> UpdateTeacher(Teacher objTeacher)
        {
            try
            {
                _lmsDbContext.Teacher.Update(objTeacher);

                //await _lmsDbContext.SaveChangesAsync();

                return 1;


            }
            catch (System.Exception ex)
            {
                _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }


        }


        public async Task<int> SaveChanges()
        {
            try
            {
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
            

        }





    }
}
