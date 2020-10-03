using LMS.Domain;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherRepository
    {
        IQueryable<Teacher> GetAllTeacher();
        Task<Teacher> GetTeacherById(int Id);

        Task<int> AddTeacher(Teacher objTeacher);
        Task<int> UpdateTeacher(Teacher objTeacher);
        Task<int> DeleteTeacher(int id);

        Teacher FindTeacherById(int Id);

        Teacher FindTeacherByRefId(string Id);
        Task<int> SaveChanges();

    }
}
