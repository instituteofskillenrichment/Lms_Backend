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
    public class SectionRepository : ISectionRepository
    {
        private LmsDbContext _lmsDbContext;

        public SectionRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task AddSection(Section objSection)
        {
            await _lmsDbContext.Section.AddAsync(objSection);
            await _lmsDbContext.SaveChangesAsync();
        }

        

        public async Task DeleteSection(int Id)
        {
            var deleteSection = await GetSectionById(Id);

            _lmsDbContext.Section.Remove(deleteSection);

            await _lmsDbContext.SaveChangesAsync();
        }



        public IQueryable<Section> GetAllSection()
        {
            IQueryable<Section> listOfClass = _lmsDbContext.Section.AsQueryable();

            return listOfClass;
        }



        public async Task<Section> GetSectionById(int Id)
        {
            var Section = await _lmsDbContext.Section
                        .AsNoTracking()
                        .FirstOrDefaultAsync(e => e.Section_Id == Id);

            return Section;
        }



        public async Task UpdateSection(Section objSection)
        {
            _lmsDbContext.Section.Update(objSection);

            await _lmsDbContext.SaveChangesAsync();
        }
    }
}
