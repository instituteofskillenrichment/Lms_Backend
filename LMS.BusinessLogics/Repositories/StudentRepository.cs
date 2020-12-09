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
        //private Logger _logger;

        public StudentRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
            //_logger = logger;
        }

        public async Task<int> AddStudent(Student objStudent)
        {

            try
            {
              await _lmsDbContext.Student.AddAsync(objStudent);

              int studentId = objStudent.Student_Id;

              return studentId;
            }
            catch (Exception ex)
            {
                //_logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
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



        public Student FindStudentById(int Id)
        {
            Student Student = _lmsDbContext.Student.Find(Id);


            return Student;
        }

        public async Task<int> UpdateStudent(Student objStudent)

        {
            try
            {
                _lmsDbContext.Student.Update(objStudent);

                //await _lmsDbContext.SaveChangesAsync();


                return 1;
            }
            catch (Exception ex)
            {
                //_logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }

            //await _lmsDbContext.SaveChangesAsync();
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


        public Student FindStudentByRefId(string Id)
        {
            var Student = _lmsDbContext.Student.Where(x => x.Student_Ref_Id == Id).FirstOrDefault();

            return Student;
        }
    }
}
