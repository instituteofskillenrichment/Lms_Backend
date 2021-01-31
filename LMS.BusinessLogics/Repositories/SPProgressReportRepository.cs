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
    public class SPProgressReportRepository : ISPProgressReportRepository
    {
        private LmsDbContext _lmsDbContext;

        public SPProgressReportRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IQueryable<Class> GetAllClass()
        {
            IQueryable<Class> listOfClass = _lmsDbContext.Class.AsQueryable();

            return listOfClass;
        }

        public IQueryable<Section> GetAllSection()
        {
            IQueryable<Section> listOfSection = _lmsDbContext.Section.AsQueryable();

            return listOfSection;
        }

        public async Task<ClassSection> GetClassSectionById(int classId, int sectionId)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                 .AsNoTracking()
                 .FirstOrDefaultAsync(cs => cs.Class_Id == classId && cs.Section_Id == sectionId);

            return ClassSection;
        }

        public IQueryable<SpProgressReportByClassSectionId> GetProgressReportByClassSectionId(string ClassSectionIdId)
        {
            return _lmsDbContext.SpProgressReportByClassSectionId.FromSql(ClassSectionIdId);
        }

        public IQueryable<SpProgressReportByStudentId> GetProgressReportByStudentId(string StudentId)
        {
            return _lmsDbContext.SpProgressReportByStudentId.FromSql(StudentId);
        }

        
    }
}
