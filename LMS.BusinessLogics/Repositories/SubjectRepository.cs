using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class SubjectRepository : ISubjectRepository
    {
        private LmsDbContext _lmsDbContext;
        public SubjectRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddSubject(Subject objSubject)
        {
            try
            {
                await _lmsDbContext.Subject.AddAsync(objSubject);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> DeleteSubject(int Id)
        {
            try
            {
                var deleteSubject = await GetSubjectById(Id);

                _lmsDbContext.Subject.Remove(deleteSubject);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<Subject> GetAllSubject()
        {
            IQueryable<Subject> listOfSubject = _lmsDbContext.Subject.OrderBy(e => e.Subject_Id).AsQueryable();

            return listOfSubject;
        }

        public async Task<Subject> GetSubjectById(int Id)
        {
            var Subject = await _lmsDbContext.Subject
                        .AsNoTracking()
                        .FirstOrDefaultAsync(e => e.Subject_Id == Id);

            return Subject;
        }

        public async Task<int> UpdateSubject(Subject objSubject)
        {
           try
            {
                _lmsDbContext.Subject.Update(objSubject);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }

        }
    }
}
