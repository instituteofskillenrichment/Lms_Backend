using LMS.Domain;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IStudentTestRepository
    {
        Task<int> AddStudentTestDetail(StudentTestDetail objTestDetail);

        IEnumerable<TestDetail> GetQuestionsByTest(int TestId);

    }
}
