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
    public class StudentClassRepository : IStudentClassRepository
    {
        private LmsDbContext _lmsDbContext;

        public StudentClassRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }



        public async Task AddStudentClass(StudentClass objStudent)
        {
            await _lmsDbContext.StudentClass.AddAsync(objStudent);
            await _lmsDbContext.SaveChangesAsync();
        }



        public async Task DeleteStudentClass(int id)
        {
            var deleteStudentClass = await GetSudentClassById(id);

            StudentClass objStudentClass = new StudentClass();
            objStudentClass.StudentClass_Id = deleteStudentClass.StudentClass_Id;
            objStudentClass.Student_Id = deleteStudentClass.Student_Id;
            objStudentClass.ClassSection_id = deleteStudentClass.ClassSection_Id;

            _lmsDbContext.StudentClass.Remove(objStudentClass);

            await _lmsDbContext.SaveChangesAsync();
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



        public IQueryable<StudentClassViewModel> GetAllStudentsClass()
        {
            IQueryable<StudentClassViewModel> StudentClass = (
                                                                 from s in _lmsDbContext.Student
                                                                 join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                                                 join cs in _lmsDbContext.ClassSection  on sc.ClassSection_id equals cs.ClassSection_id
                                                                 join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id 
                                                                 join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id
                                                                 
                                                                 
                                                                  select new StudentClassViewModel
                                                                  {
                                                                      StudentClass_Id = sc.StudentClass_Id,
                                                                      Student_Id = s.Student_Id,
                                                                      Student_Name = s.Student_Name,
                                                                      ClassSection_Id = cs.ClassSection_id,
                                                                      Class_Name = c.Class_Name,
                                                                      //Section_Id = s.Section_Id,
                                                                      Section_Name = sec.Section_Name,
                                                                      //Subject_Id = sub.Subject_Id,
                                                                      //Subject_Name = sub.Subject_Name
                                                                 
                                                                 
                                                                  }).AsQueryable();

            return StudentClass;
        }



        public IQueryable<StudentClassViewModel> GetStudentSubjectByStudentId(int StudentId)
        {
            IQueryable<StudentClassViewModel> StudentClass = (
                                                                 from s in _lmsDbContext.Student
                                                                 join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                                                 join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                                                 join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                                                 join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id
                                                                 join csub in _lmsDbContext.ClassSubject on cs.ClassSection_id equals csub.ClassSection_Id
                                                                 join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                                 where s.Student_Id == StudentId
                                                                 select new StudentClassViewModel
                                                                 {
                                                                     StudentClass_Id = sc.StudentClass_Id,
                                                                     Student_Id = s.Student_Id,
                                                                     Student_Name = s.Student_Name,
                                                                     ClassSection_Id = cs.ClassSection_id,
                                                                     Class_Name = c.Class_Name,
                                                                     //Section_Id = sec.Section_Id,
                                                                     Section_Name = sec.Section_Name,
                                                                     ClassSubject_Id = csub.ClassSubject_Id,
                                                                     //Subject_Id = sub.Subject_Id,
                                                                     Subject_Name = sub.Subject_Name


                                                                 }).AsQueryable();

            return StudentClass;
        }



        public async Task<ClassSection> GetClassSectionById(int classId, int sectionId)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                 .AsNoTracking()
                 .FirstOrDefaultAsync(cs => cs.Class_Id == classId && cs.Section_Id == sectionId);

            return ClassSection;
        }



        public Task<StudentClassViewModel> GetSudentClassById(int Id)
        {
            var StudentClass = (
                                 from s in _lmsDbContext.Student
                                 join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                 join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                 join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                 join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id


                                 select new StudentClassViewModel
                                 {
                                     StudentClass_Id = sc.StudentClass_Id,
                                     Student_Id = s.Student_Id,
                                     Student_Name = s.Student_Name,
                                     ClassSection_Id = cs.ClassSection_id,
                                     Class_Id = c.Class_Id,
                                     Class_Name = c.Class_Name,
                                     Section_Id = sec.Section_Id,
                                     Section_Name = sec.Section_Name,
                                     //Subject_Id = sub.Subject_Id,
                                     //Subject_Name = sub.Subject_Name


                                 })
                                 .AsNoTracking().FirstOrDefaultAsync(sc => sc.StudentClass_Id == Id);
            return StudentClass;
        }



        public async Task UpdateStudentClass(StudentClass objStudentClass)
        {
            _lmsDbContext.StudentClass.Update(objStudentClass);

            await _lmsDbContext.SaveChangesAsync();
        }


    }
}
