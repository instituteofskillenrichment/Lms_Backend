using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class SPStudentClassSubjectRepository : ISPStudentClassSubjectRepository
    {
        private LmsDbContext _lmsDbContext;

        public SPStudentClassSubjectRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext; 
        }

        public IQueryable<StudentClassViewModel> GetStudentClassSubjectstDistinctByStudentId(int StudentId)
        {
            IQueryable<StudentClassViewModel> StudentClassSubjects =  
                                              (from s in _lmsDbContext.Student
                                              join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id
                                              join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                              join c in _lmsDbContext.Class on cs.Class_Id equals c.Class_Id
                                              join sec in _lmsDbContext.Section on cs.Section_Id equals sec.Section_Id
                                              join csub in _lmsDbContext.ClassSubject on cs.ClassSection_id equals csub.ClassSection_Id
                                              join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                              where s.Student_Id == StudentId &&
                                              sc.ClassSection_id == cs.ClassSection_id &&
                                              cs.ClassSection_id == csub.ClassSection_Id
                                              select new StudentClassViewModel
                                              {
                                                  //StudentClass_Id = sc.StudentClass_Id,
                                                  Student_Id = s.Student_Id,
                                                  Student_Name = s.Student_Name,
                                                  //ClassSection_Id = cs.ClassSection_id,
                                                  Class_Id = c.Class_Id,
                                                  Class_Name = c.Class_Name,
                                                  Section_Id = sec.Section_Id,
                                                  Section_Name = sec.Section_Name,
                                                  //ClassSubject_Id = csub.ClassSubject_Id,
                                                  Subject_Id = sub.Subject_Id,
                                                  Subject_Name = sub.Subject_Name


                                              }).AsQueryable().Distinct();

            return StudentClassSubjects;
        }
    }
}
