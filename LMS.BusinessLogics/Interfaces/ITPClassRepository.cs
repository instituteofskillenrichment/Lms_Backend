using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITPClassRepository
    {
        IQueryable<TeacherSubjectViewModel> GetTeacherClassSubjectstDistinctByTeacherId(int TeacherId);
        IEnumerable<SubjectLectureViewModel> GetTeacherClassSubjectLectures(int TeacherId, int classSectionId);
        Task<ClassSubject> GetClassSubjectById(int classSectionId, int subjectId);
        Task<ClassSection> GetClassSectionById(int classId, int sectionId);


    }
}
