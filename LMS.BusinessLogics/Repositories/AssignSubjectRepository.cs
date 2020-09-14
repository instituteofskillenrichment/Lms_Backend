using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
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



        public Task AddClassSubject(ClassSubject objClassSubject)
        {
            throw new NotImplementedException();
        }

        public Task DeleteClassSubject(int Id)
        {
            throw new NotImplementedException();
        }

        

        

       

        public Task<ClassSubject> GetClassSubjectById(int Id)
        {
            throw new NotImplementedException();
        }

        public Task UpdateClassSubject(ClassSubject objClassSubject)
        {
            throw new NotImplementedException();
        }
    }
}
