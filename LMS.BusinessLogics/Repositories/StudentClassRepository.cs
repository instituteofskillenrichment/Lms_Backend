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



        public async Task<int> AddStudentClass(StudentClass objStudent)
        {
            try
            {
                await _lmsDbContext.StudentClass.AddAsync(objStudent);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }



        public async Task<int> DeleteStudentClass(int id)
        {
            try
            {
                var deleteStudentClass = await GetSudentClassById(id);

                StudentClass objStudentClass = new StudentClass();
                objStudentClass.StudentClass_Id = deleteStudentClass.StudentClass_Id;
                objStudentClass.Student_Id = deleteStudentClass.Student_Id;
                objStudentClass.ClassSection_id = deleteStudentClass.ClassSection_Id;

                _lmsDbContext.StudentClass.Remove(objStudentClass);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
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



        public async Task<int> UpdateStudentClass(StudentClass objStudentClass)
        {
            try
            {
                _lmsDbContext.StudentClass.Update(objStudentClass);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        //created by arib
        public IEnumerable<StudentTestViewModel> GetTestsByStudentId(int StudentId)
        {
            IEnumerable<StudentTestViewModel> StudentClass =  (
                                                                 from s in _lmsDbContext.Student
                                                                 join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                                                 join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                                                 join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                                                 join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id
                                                                 join csub in _lmsDbContext.ClassSubject on cs.ClassSection_id equals csub.ClassSection_Id
                                                                 join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                                 join t in _lmsDbContext.Test on csub.Subject_Id equals t.Subject_Id
                                                                 join td in _lmsDbContext.TestDetail on t.Test_Id equals td.Test_Id
                                                                 where 
                                                                 s.Student_Id == StudentId
                                                                 && t.Subject_Id == sub.Subject_Id
                                                                 && t.Class_Id == cs.Class_Id
                                                                 && t.Section_Id == cs.Section_Id
                                                                 group new { t.Test_Id, sc.ClassSection.Class, sc.ClassSection.Section, csub.Subject } 
                                                                 by new
                                                                 {
                                                                     t.Test_Id,
                                                                     t.Test_Name,
                                                                     t.Class_Id,
                                                                     csub.ClassSection.Class.Class_Name,
                                                                     t.Section_Id,
                                                                     csub.ClassSection.Section.Section_Name,
                                                                     t.Subject_Id,
                                                                     csub.Subject.Subject_Name,
                                                                     t.Assessment_Date
                                                                 } into g
                                                                 orderby g.Key.Assessment_Date descending
                                                                 select new StudentTestViewModel
                                                                 {

                                                                     Class_Id = g.Key.Class_Id,
                                                                     Class_Name = g.Key.Class_Name,
                                                                     Section_Id = g.Key.Section_Id,
                                                                     Section_Name = g.Key.Section_Name,
                                                                     Subject_Id = g.Key.Subject_Id,
                                                                     Subject_Name = g.Key.Subject_Name,
                                                                     Test_Name = g.Key.Test_Name,
                                                                     Test_Id = g.Key.Test_Id,
                                                                     Assessment_Date = DateTime.ParseExact(g.Key.Assessment_Date, "yyyyMMdd", null)


                                                                 }).ToList();

            return StudentClass;
        }

    }
}
