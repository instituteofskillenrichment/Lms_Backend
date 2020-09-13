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
    public class StudentRepository : IStudentRepository
    {
        private LmsDbContext _lmsDbContext;
        private ILogger _logger;

        public StudentRepository(LmsDbContext lmsDbContext, ILogger logger)
        {
            _lmsDbContext = lmsDbContext;
            _logger = logger;
        }

        public async Task<int> AddStudent(Student objStudent)
        {
            try
            {
                await _lmsDbContext.Student.AddAsync(objStudent);
                await _lmsDbContext.SaveChangesAsync();
                return 1;
            }
            catch (Exception ex)
            {
                _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }
        }

        public async Task<int> DeleteStudent(int id)
        {
            try
            {
                var deleteStudent = await GetStudentById(id);

                _lmsDbContext.Student.Remove(deleteStudent);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {

                return -1;
            }
        }

        public IQueryable<Student> GetAllStudent()
        {
            IQueryable<Student> listOfStudent = _lmsDbContext.Student.AsQueryable();

            return listOfStudent;
        }

        public async Task<Student> GetStudentById(int Id)
        {
            var Student = await _lmsDbContext.Student
                       .AsNoTracking()
                       .FirstOrDefaultAsync(c => c.Student_Id == Id);

            return Student;
        }

        public async Task<int> UpdateStudent(Student objStudent)
        {
            try
            {
                _lmsDbContext.Student.Update(objStudent);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }
        }
    }
}
