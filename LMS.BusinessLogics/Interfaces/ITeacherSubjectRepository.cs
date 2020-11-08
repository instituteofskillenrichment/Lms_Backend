using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherSubjectRepository
    {
        List<Subject> GetAllSubjects();
        List<Class> GetAllClasses();
        List<Section> GetAllSections();
        Task<ClassSection> GetClassSectionById(int classId, int sectionId);
        Task<ClassSubject> GetClassSubjectById(int classSectionId, int subjectId);
        IQueryable<TeacherSubjectViewModel> GetTeacherSubjects();
        IQueryable<TeacherSubjectViewModel> GetTeacherClassSubjectstByTeacherId(int TeacherId);
        Task<int> AddTeacherSubject(TeacherSubject objTeacherSubject);
        Task<TeacherSubjectViewModel> GetTeacherSubjectById(int TeacherSubject_Id);
        Task<int> DeleteTeacherSubject(int TeacherSubject_Id);
        Task<int> EditTeacherSubject(TeacherSubject objTeacherSubject);
        
        
    }
}
