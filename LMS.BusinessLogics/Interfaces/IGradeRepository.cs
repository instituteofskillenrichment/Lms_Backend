using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IGradeRepository
    {

        IQueryable<GradeViewModel> GetAllGrades();


        List<Class> GetAllClasses();
        List<Section> GetAllSections();
        List<Subject> GetAllSubjects();


        List<GradeViewModel> GetAllClassSectionByClassId(int classId);
        Task<Grade> GetGradeById(int Id);

        Task<int> AddGrade(List<Grade> objGrade);
        Task<int> DeleteGrade(int id);
        Task<int> UpdateGrade(Grade objGrade);
    }
}
