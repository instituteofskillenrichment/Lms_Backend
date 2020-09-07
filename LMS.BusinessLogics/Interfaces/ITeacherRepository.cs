using LMS.Domain;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherRepository
    {
        IQueryable<Teacher> GetAllTeacher();
        Task<Teacher> GetTeacherById(int Id);
        Task AddTeacher(Teacher objTeacher);
        Task UpdateTeacher(Teacher objTeacher);
        Task DeleteTeacher(int id);
        
    }
}
