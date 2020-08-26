using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class StudentRepository : IStudentRepository
    {
        private LmsDbContext _lmsDbContext;

        public StudentRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task AddStudent(Student objStudent)
        {
            await _lmsDbContext.Student.AddAsync(objStudent);
            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteStudent(int id)
        {
            var deleteStudent = await GetStudentById(id);

            _lmsDbContext.Student.Remove(deleteStudent);

            await _lmsDbContext.SaveChangesAsync();
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

        public async Task UpdateStudent(Student objStudent)
        {
            _lmsDbContext.Student.Update(objStudent);

            await _lmsDbContext.SaveChangesAsync();
        }
    }
}
