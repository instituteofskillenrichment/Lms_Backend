using LMS.Domain;
using LMS.Domain.ViewModels;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherGradeRepository
    {
        //Task<IQueryable<SpStudentGradeBySubjectId>> GetAllStudentsBySubjectId(int SubjectId);

        IQueryable<SpStudentGradeByTestId> GetStudentsAllTestResults(string StudentId);

        IQueryable<SpStudentGradeBySubjectId> RunSql(string SubjectId);
    }
}
