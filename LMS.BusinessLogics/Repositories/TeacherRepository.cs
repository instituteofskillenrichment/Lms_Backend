using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;


namespace LMS.BusinessLogics.Repositories
{
    public class TeacherRepository : ITeacherRepository
    {
        private LmsDbContext _lmsDbContext;
        
        public TeacherRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
            
        }

        public async Task<int> AddTeacher(Teacher objTeacher)
        {
            await _lmsDbContext.Teacher.AddAsync(objTeacher);
            

            int teacherId = objTeacher.Teacher_Id;

            return teacherId;

            //await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteTeacher(int id)
        {
            var deleteTeacher = await GetTeacherById(id);

            _lmsDbContext.Teacher.Remove(deleteTeacher);

            await _lmsDbContext.SaveChangesAsync();
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

        public async Task UpdateTeacher(Teacher objTeacher)
        {
            _lmsDbContext.Teacher.Update(objTeacher);

            //await _lmsDbContext.SaveChangesAsync();
        }


        public async Task SaveChanges()
        {
            await _lmsDbContext.SaveChangesAsync();
        }





    }
}
