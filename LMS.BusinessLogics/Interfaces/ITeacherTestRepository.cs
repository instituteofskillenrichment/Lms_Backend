using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITeacherTestRepository
    {
        IQueryable<TestType> GetAllTestType();
        Task<Test> GetTestById(int Id);
        Task<TestDetail> GetQuestionById(int Id);
        Task<int> AddTeacherTestDetail(TestDetail objTestDetail);
        Task<int> AddTeacherTest(Test objTest);
        IEnumerable<TestListViewModel> GetTestsByTeacher(int TeacherId);
        IEnumerable<TestDetailViewModel> GetQuestionsByTest(int TestId);
        Task DeleteTest(int TestId);
        Task DeleteQuestion(int QuestionId);
        Task<int> UpdateTeacherTestDetail(TestDetail objTestDetail);
        Task<int> UpdateTeacherTest(Test objTest);
        IEnumerable<StudentAttemptTestViewModel> GetStudentsByTest(int TestId);
        IEnumerable<StudentTestResultViewModel> GetStudentTestResult(int StudentId, int TestId);
        Task<StudentTestDetail> GetStudentTestDetailById(int StudentId, int TestId, int QuestionId);

        Task<int> UpdateStudentTestDetail(StudentTestDetail objStudentTestDetail);
    }
}
