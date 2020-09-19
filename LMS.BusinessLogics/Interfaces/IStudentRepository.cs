using LMS.Domain;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IStudentRepository
    {
        IQueryable<Student> GetAllStudent();
        Task<Student> GetStudentById(int Id);

        Task<int> AddStudent(Student objStudent);
        Task<int> UpdateStudent(Student objStudent);
        Task<int> DeleteStudent(int id);

        Student FindStudentById(int Id);
        
        Task SaveChanges();

    }
}
