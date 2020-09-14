using LMS.Domain;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IStudentRepository
    {
        IQueryable<Student> GetAllStudent();
        Task<Student> GetStudentById(int Id);
        Student FindStudentById(int Id);
        Task<int> AddStudent(Student objStudent);
        Task UpdateStudent(Student objStudent);
        Task DeleteStudent(int id);
        Task SaveChanges();
    }
}
