using LMS.Domain;
using LMS.Domain.ViewModels;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IStudentTestRepository
    {
        Task<int> AddStudentTestDetail(StudentTestDetail objTestDetail);

        IEnumerable<TestDetail> GetQuestionsByTest(int TestId);

        IEnumerable<StudentTestResultViewModel> GetStudentTestResult(int TestId, int StudentId);


    }
}
