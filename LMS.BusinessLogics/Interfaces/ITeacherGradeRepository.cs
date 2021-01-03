using LMS.Domain.ViewModels;
using System.Collections.Generic;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherGradeRepository
    {
        IEnumerable<StudentGradeViewModel> GetAllStudentsBySubjectId(int SubjectId);


        IEnumerable<StudentTestDetailViewModel> GetStudentsAllTestResults(int StudentId);
    }
}
