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
    public class TeacherTestRepository : ITeacherTestRepository
    {
        private LmsDbContext _lmsDbContext;

        public TeacherTestRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IQueryable<TestType> GetAllTestType()
        {
            IQueryable<TestType> listOfTestType = _lmsDbContext.TestType.AsQueryable();

            return listOfTestType;
        }

        public async Task<int> AddTeacherTestDetail(TestDetail objTestDetail)
        {
            try
            {
                await _lmsDbContext.TestDetail.AddAsync(objTestDetail);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception)
            {
                return -1;

            }
        }

        public async Task<int> AddTeacherTest(Test objTest)
        {
            try
            {
                await _lmsDbContext.Test.AddAsync(objTest);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IEnumerable<TestListViewModel> GetTestsByTeacher(int TeacherId)
        {
            var Tests = (
                            from t in _lmsDbContext.Test
                            where t.Teacher_Id == TeacherId 
                            select new TestListViewModel
                            {
                                Test_Id = t.Test_Id,
                                Test_Name = t.Test_Name,
                                Questions_Count =
                                (from td in _lmsDbContext.TestDetail
                                where td.Test_Id == t.Test_Id
                                select new
                                {
                                    td.Question_Name
                                }).Count(p => p.Question_Name != null)
                            }).ToList();
            return Tests;
        }

        public IEnumerable<TestDetailViewModel> GetQuestionsByTest(int TestId)
        {
            var Questions = (
                           from t in _lmsDbContext.TestDetail
                           where t.Test_Id == TestId
                           select new TestDetailViewModel
                           {
                               Question_Id = t.Question_Id,
                               Question_Name = t.Question_Name,
                               Options_Count = t.Test_Type_Id != 1 ? 0 : string.IsNullOrEmpty(t.Option_2) ? 1 : string.IsNullOrEmpty(t.Option_3) ? 2 : string.IsNullOrEmpty(t.Option_4) ? 3 : 4
                           }).ToList();

            return Questions;
        }

        public async Task<Test> GetTestById(int Id)
        {
            var Test = await _lmsDbContext.Test
                      .AsNoTracking()
                      .FirstOrDefaultAsync(t => t.Test_Id == Id);

            return Test;
        }

        public async Task<TestDetail> GetQuestionById(int Id)
        {
            var Question = await _lmsDbContext.TestDetail
                      .AsNoTracking()
                      .FirstOrDefaultAsync(q => q.Question_Id == Id);

            return Question;
        }

        public async Task DeleteTest(int TestId)
        {
            var deleteTest = await GetTestById(TestId);

            _lmsDbContext.Test.Remove(deleteTest);

            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteQuestion(int QuestionId)
        {
            var deleteQuestion = await GetQuestionById(QuestionId);

            _lmsDbContext.TestDetail.Remove(deleteQuestion);

            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task<int> UpdateTeacherTestDetail(TestDetail objTestDetail)
        {
            try
            {
                _lmsDbContext.TestDetail.Update(objTestDetail);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> UpdateTeacherTest(Test objTest)
        {
            try
            {
                 _lmsDbContext.Test.Update(objTest);
                
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }
}
