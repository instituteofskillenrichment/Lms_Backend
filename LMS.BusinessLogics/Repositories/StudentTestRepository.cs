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


    }
}
