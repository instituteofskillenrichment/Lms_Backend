using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IClassRepository
    {
        IQueryable<Class> GetAllClass();
        Task<Class> GetClassById(int Id);
        Task<int> AddClass(Class objClass);
        Task<int> UpdateClass(Class objClass);
        Task<int> DeleteClass(int id);

    }
}
