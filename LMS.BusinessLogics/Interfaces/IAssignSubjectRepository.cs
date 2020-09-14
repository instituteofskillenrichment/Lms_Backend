using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IAssignSubjectRepository
    {
        IQueryable<AssignSubjectViewModel> GetAllClassesSubjects();
        List<Class> GetAllClasses();
        List<Section> GetAllSections();
        List<Subject> GetAllSubjects();
        Task<ClassSubject> GetClassSubjectById(int Id);
        Task AddClassSubject(ClassSubject objClassSubject);
        Task UpdateClassSubject(ClassSubject objClassSubject);
        Task DeleteClassSubject(int Id);
    }
}
