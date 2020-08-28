using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IAssignSectionRepository
    {
        IQueryable<AssignSectionViewModel> GetAllClasSection();
        IQueryable<Class> GetAllClass();
        IQueryable<Section> GetAllSection();
        Task<ClassSection> GetClassSectionById(int Id);
        Task AddClassSection(ClassSection objClassSection);
        Task UpdateClassSection(ClassSection objClassSection);
        Task DeleteClassSection(int Id);
    }
}
