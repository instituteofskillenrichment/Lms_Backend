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
        //IQueryable<AssignSectionViewModel> GetAllClasSection();
        IQueryable<AssignSectionViewModel> GetAllClasSection();
        IQueryable<Class> GetAllClass();
        IQueryable<Section> GetAllSection();
        Task<ClassSection> GetClassSectionById(int Id);
        Task<int> AddClassSection(ClassSection objClassSection);
        Task<int> UpdateClassSection(ClassSection objClassSection);
        Task<int> DeleteClassSection(int Id);
    }
}
