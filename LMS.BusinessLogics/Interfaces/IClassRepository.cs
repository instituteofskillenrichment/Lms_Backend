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
        Task AddClass(Class objClass);
        Task UpdateClass(Class objClass);
        Task DeleteClass(int id);

    }
}
