using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class StudentTestRepository : IStudentTestRepository
    {
        private LmsDbContext _lmsDbContext;

        public StudentTestRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddStudentTestDetail(StudentTestDetail objTestDetail)
        {
            try
            {
                await _lmsDbContext.StudentTestDetail.AddAsync(objTestDetail);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;

            }
        }
    
        public IEnumerable<TestDetail> GetQuestionsByTest(int TestId)
        {
            var Questions = _lmsDbContext.TestDetail.Where(x => x.Test_Id == TestId).ToList();

            return Questions;
        }

        public IEnumerable<StudentTestResultViewModel> GetStudentTestResult(int TestId, int StudentId)
        {
            var TestResult = (
                                from std in _lmsDbContext.StudentTestDetail
                                join t in _lmsDbContext.TestDetail
                                on new { std.Test_Id, std.Question_Id } equals new { t.Test_Id, t.Question_Id }
                                where std.Test_Id == TestId && std.Student_Id == StudentId
                                select new StudentTestResultViewModel
                                {
                                    Test_Id = std.Test_Id,
                                    Student_Id = std.Student_Id,
                                    Student_Name = std.Student.Student_Name,
                                    Question = t.Question_Name,
                                    Answer = std.Answer,
                                    CorrectAnswer = t.Correct_Answer ?? "Subjected on Teacher",
                                    Answer_Type_Id = std.Answer_Type_Id,
                                    Marks_Obtained = std.Marks_Obtained,
                                    Marks = t.Question_Marks,
                                    Question_Id = std.Question_Id,
                                    Total_Obtained = (from std2 in _lmsDbContext.StudentTestDetail 
                                                      where std2.Student_Id == StudentId
                                                      && std2.Test_Id == TestId
                                                      select new
                                                      {
                                                          
                                                          std2.Marks_Obtained
                                                      }).Sum(s => s.Marks_Obtained)
                                }
                             ).ToList();

            return TestResult;
        }
    }
}
