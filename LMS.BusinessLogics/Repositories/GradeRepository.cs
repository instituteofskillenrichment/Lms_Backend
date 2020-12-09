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
    public class GradeRepository : IGradeRepository
    {
        private LmsDbContext _lmsDbContext;

        public GradeRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IQueryable<GradeViewModel> GetAllGrades()
        {
            IQueryable<GradeViewModel> listOfGrade = (from g in _lmsDbContext.Grade
                                                     join c in _lmsDbContext.Class on g.Class_Id equals c.Class_Id
                                                     join s in _lmsDbContext.Section on g.Section_Id equals s.Section_Id
                                                     join sub in _lmsDbContext.Subject on g.Subject_Id equals sub.Subject_Id
                                                     orderby c.Class_Name, s.Section_Name
                                                     select new GradeViewModel
                                                     {
                                                         Grade_Id = g.Grade_Id,
                                                         Grade_Name = g.Grade_Name,
                                                         Start_From = g.Start_From,
                                                         End_On = g.End_On,
                                                         Class_Name = c.Class_Name,
                                                         Section_Name = s.Section_Name,
                                                         Subject_Name = sub.Subject_Name
                                                     }).AsQueryable();

            return listOfGrade;
        }

        public List<Class> GetAllClasses()
        {
            List<Class> Classes = _lmsDbContext.Class.ToList();


            return Classes;
        }

        public List<Section> GetAllSections()
        {
            List<Section> Sections = _lmsDbContext.Section.ToList();

            return Sections;
        }

        public List<Subject> GetAllSubjects()
        {
            List<Subject> Subjects = _lmsDbContext.Subject.ToList();

            return Subjects;
        }

        public List<GradeViewModel> GetAllClassSectionByClassId(int classId)
        {
            List<GradeViewModel> ClassSection = (from csec in _lmsDbContext.ClassSection
                                                 where csec.Class_Id == classId
                                                 select new GradeViewModel
                                                 {
                                                     Class_Id = csec.Class_Id,
                                                     Section_Id = csec.Section_Id
                                                 }).ToList();
                //_lmsDbContext.ClassSection.Where(cl => cl.Class_Id == classId).ToList();


            return ClassSection;

        }

        public async Task<int> AddGrade(List<Grade> objGrade)
        {
            try
            {

                await _lmsDbContext.Grade.AddRangeAsync(objGrade);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> DeleteGrade(int id)
        {
            try
            {
                var deleteGrade = await GetGradeById(id);

                _lmsDbContext.Grade.Remove(deleteGrade);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public async Task<Grade> GetGradeById(int Id)
        {
            var Grade = await _lmsDbContext.Grade
                        .AsNoTracking()
                        .FirstOrDefaultAsync(g => g.Grade_Id == Id);

            return Grade;
        }

        public async Task<int> UpdateGrade(Grade objGrade)
        {
            try
            {
                _lmsDbContext.Grade.Update(objGrade);

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
