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



        public async Task<int> AddClassSection(ClassSection objClassSection)
        {
            try
            {
                await _lmsDbContext.ClassSection.AddAsync(objClassSection);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public async Task<int> DeleteClassSection(int Id)
        {
            try
            {
                var deleteClassSection = await GetClassSectionById(Id);

                _lmsDbContext.ClassSection.Remove(deleteClassSection);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public IQueryable<AssignSectionViewModel> GetAllClasSection()
        {
            IQueryable<AssignSectionViewModel> ClassSection = (from cs in _lmsDbContext.ClassSection
                                                               join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                                               join s in _lmsDbContext.Section on cs.Section_Id equals s.Section_Id
                                                               select new AssignSectionViewModel
                                                               {
                                                                   ClassSection_Id = cs.ClassSection_id,
                                                                   Class_Id = c.Class_Id,
                                                                   Class_Name = c.Class_Name,
                                                                   Section_Id = s.Section_Id,
                                                                   Section_Name = s.Section_Name


                                                               }).AsQueryable();


            //var ClassSection =
            //     from cs in _lmsDbContext.ClassSection
            //     join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id into classGrp
            //     join s in _lmsDbContext.Section on cs.Section_Id equals s.Section_Id into sectionGrp
            //     orderby cs.ClassSection_id
            //     select new AssignSectionViewModel
            //     {
            //         ClassSection_Id = cs.ClassSection_id,

            //         Classes = (from c2 in classGrp
            //                    orderby c2.Class_Name
            //                    select c2).ToList(),
            //         Sections = (from s2 in sectionGrp
            //                     orderby s2.Section_Name
            //                     select s2).ToList()
            //     };


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



        public async Task<int> UpdateClassSection(ClassSection objClassSection)
        {
            try
            {
                _lmsDbContext.ClassSection.Update(objClassSection);

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
