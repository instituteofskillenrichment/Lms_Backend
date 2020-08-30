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

        public async Task AddSubject(Subject objSubject)
        {
            await _lmsDbContext.Subject.AddAsync(objSubject);
            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteSubject(int Id)
        {
            var deleteSubject = await GetSubjectById(Id);

            _lmsDbContext.Subject.Remove(deleteSubject);

            await _lmsDbContext.SaveChangesAsync();
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

        public async Task UpdateSubject(Subject objSubject)
        {
            _lmsDbContext.Subject.Update(objSubject);

            await _lmsDbContext.SaveChangesAsync();
        }
    }
}
