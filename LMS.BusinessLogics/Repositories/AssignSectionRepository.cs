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
    public class AssignSectionRepository : IAssignSectionRepository
    {
        private LmsDbContext _lmsDbContext;

        public AssignSectionRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task AddClassSection(ClassSection objClassSection)
        {
            await _lmsDbContext.ClassSection.AddAsync(objClassSection);
            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteClassSection(int Id)
        {
            var deleteClassSection = await GetClassSectionById(Id);

            _lmsDbContext.ClassSection.Remove(deleteClassSection);

            await _lmsDbContext.SaveChangesAsync();
        }

        public IQueryable<AssignSectionViewModel> GetAllClasSection()
        {
            IQueryable<AssignSectionViewModel> ClassSection = (from cs in _lmsDbContext.ClassSection
                                                                    join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                                                    join s in _lmsDbContext.Section on cs.Section_Id equals s.Section_Id
                                                                    select new AssignSectionViewModel
                                                                    {
                                                                       ClassSection_Id = cs.ClassSection_id,
                                                                       ClassId = c.Class_Id,
                                                                        ClassName =  c.Class_Name,
                                                                        SectionId = s.Section_Id,
                                                                        SectionName =  s.Section_Name


                                                                    }).AsQueryable();

            

           // IQueryable <ClassSection> listOfClassSection = _lmsDbContext.ClassSection.AsQueryable();

            return ClassSection;
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




        public async Task<ClassSection> GetClassSectionById(int Id)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                        .AsNoTracking()
                        .FirstOrDefaultAsync(e => e.ClassSection_id == Id);

            return ClassSection;
        }

        public async Task UpdateClassSection(ClassSection objClassSection)
        {
            _lmsDbContext.ClassSection.Update(objClassSection);

            await _lmsDbContext.SaveChangesAsync();
        }
    }
}
