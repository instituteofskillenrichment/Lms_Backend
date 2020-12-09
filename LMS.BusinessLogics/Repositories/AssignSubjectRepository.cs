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
    public class AssignSubjectRepository : IAssignSubjectRepository
    {
        private LmsDbContext _lmsDbContext;

        public AssignSubjectRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IQueryable<AssignSubjectViewModel> GetAllClassesSubjects()
        {
            IQueryable<AssignSubjectViewModel> ClassSubject = (from csub in _lmsDbContext.ClassSubject
                                                               join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                                               join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                               join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                               join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                                                               orderby c.Class_Id, s.Section_Id
                                                               select new AssignSubjectViewModel
                                                               {
                                                                   ClassSubject_Id = csub.ClassSubject_Id,
                                                                   ClassSection_Id = csec.ClassSection_id,
                                                                   Class_Id = c.Class_Id,
                                                                   Class_Name = c.Class_Name,
                                                                   Section_Id = s.Section_Id,
                                                                   Section_Name = s.Section_Name,
                                                                   Subject_Id =sub.Subject_Id,
                                                                   Subject_Name = sub.Subject_Name


                                                               }).AsQueryable();

            return ClassSubject;
        }



        public IQueryable<AssignSubjectViewModel> GetAllSubjectsByClassSection(int ClassSectionId)
        {
            IQueryable<AssignSubjectViewModel> ClassSubject =   (from csub in _lmsDbContext.ClassSubject
                                                               join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                                               join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                               join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                               join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                                                               where csub.ClassSection_Id == ClassSectionId
                                                               select new AssignSubjectViewModel
                                                               {
                                                                   ClassSubject_Id = csub.ClassSubject_Id,
                                                                   ClassSection_Id = csec.ClassSection_id,
                                                                   Class_Id = c.Class_Id,
                                                                   Class_Name = c.Class_Name,
                                                                   Section_Id = s.Section_Id,
                                                                   Section_Name = s.Section_Name,
                                                                   Subject_Id = sub.Subject_Id,
                                                                   Subject_Name = sub.Subject_Name


                                                               }).AsQueryable();

            return ClassSubject;
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



        public Task<AssignSubjectViewModel> GetClassSubjectById(int Id)
        {
            var ClassSubject = (from csub in _lmsDbContext.ClassSubject
                                join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                               // where csub.ClassSubject_Id
                                select new AssignSubjectViewModel
                                {
                                    ClassSubject_Id = csub.ClassSubject_Id,
                                    ClassSection_Id = csec.ClassSection_id,
                                    Class_Id = c.Class_Id,
                                    Class_Name = c.Class_Name,
                                    Section_Id = s.Section_Id,
                                    Section_Name = s.Section_Name,
                                    Subject_Id = sub.Subject_Id,
                                    Subject_Name = sub.Subject_Name


                                })
                                //.Where(csub => csub.ClassSubject_Id == Id).AsNoTracking().FirstOrDefaultAsync();
                                .AsNoTracking().FirstOrDefaultAsync(cs => cs.ClassSubject_Id == Id); 

            return ClassSubject;
        }



        public async Task<ClassSection> GetClassSectionById(int classId, int sectionId)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                 .AsNoTracking()
                 .FirstOrDefaultAsync(cs => cs.Class_Id == classId && cs.Section_Id == sectionId);

            return ClassSection;
        }



        public async Task<int> AddClassSubject(ClassSubject objClassSubject)
        {
            try
            {
                await _lmsDbContext.ClassSubject.AddAsync(objClassSubject);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> DeleteClassSubject(int Id)
        {
            try
            {
                var deleteClassSubject = await GetClassSubjectById(Id);

                ClassSubject objClassSubject = new ClassSubject();
                objClassSubject.ClassSubject_Id = deleteClassSubject.ClassSubject_Id;
                objClassSubject.ClassSection_Id = deleteClassSubject.ClassSection_Id;
                objClassSubject.Subject_Id = deleteClassSubject.Subject_Id;

                _lmsDbContext.ClassSubject.Remove(objClassSubject);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }


        public async Task<int> UpdateClassSubject(ClassSubject objClassSubject)
        {
            try
            {
                _lmsDbContext.ClassSubject.Update(objClassSubject);

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
