using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LMS.BusinessLogics.Repositories
{
    public class TeacherGradeRepository : ITeacherGradeRepository
    {

        private LmsDbContext _lmsDbContext;

        public TeacherGradeRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IEnumerable<StudentGradeViewModel> GetAllStudentsBySubjectId(int SubjectId)
        {
            IEnumerable<StudentGradeViewModel> AllStudents = (from s in _lmsDbContext.Student
                                                              join std in _lmsDbContext.StudentTestDetail on s.Student_Id equals std.Student_Id into std_join
                                                              from std in std_join.DefaultIfEmpty()
                                                              join t in _lmsDbContext.Test on std.Test_Id equals t.Test_Id into t_join
                                                              from t in t_join.DefaultIfEmpty()
                                                              join sc in _lmsDbContext.StudentClass on s.Student_Id equals sc.Student_Id into sc_join
                                                              from sc in sc_join.DefaultIfEmpty()
                                                              join cs in _lmsDbContext.ClassSubject on new { ClassSection_Id = sc.ClassSection_id } equals new { ClassSection_Id = cs.ClassSection_Id } into cs_join
                                                              from cs in cs_join.DefaultIfEmpty()
                                                              where cs.Subject_Id == SubjectId
                                                              group new { s, t, std } by new
                                                              {
                                                                  s.Student_Id,
                                                                  s.Student_Name,
                                                                  t.Total_Makrs,
                                                                  std.Marks_Obtained
                                                              } into g
                                                              select new StudentGradeViewModel()
                                                              {
                                                                  Student_Id = (int)g.Key.Student_Id,
                                                                  Student_Name = g.Key.Student_Name,
                                                                  Total_Marks = (int?)g.Sum(p => p.t.Total_Makrs),
                                                                  Obtained_Marks = (double?)((Convert.ToDouble(g.Sum(p => p.std.Marks_Obtained)) / Convert.ToDouble(g.Sum(p => p.t.Total_Makrs))) * Convert.ToDouble(g.Sum(p => p.t.Weighatge))),
                                                                  Grade =
                                                                  ((from Grade in _lmsDbContext.Grade
                                                                    where Grade.Subject_Id == SubjectId &&
                                                                    g.Key.Marks_Obtained >= Grade.Start_From && g.Key.Marks_Obtained <= Grade.End_On
                                                                    select new
                                                                    {
                                                                        Grade.Grade_Name
                                                                    }).Take(1).First().Grade_Name)
                                                              }).Distinct();

            return AllStudents;
        }

        public IEnumerable<StudentTestDetailViewModel> GetStudentsAllTestResults(int StudentId)
        {
            IEnumerable<StudentTestDetailViewModel> Student = (from std in _lmsDbContext.StudentTestDetail
                                                               where std.Student_Id == StudentId
                                                               select new StudentTestDetailViewModel()
                                                               {
                                                                   Student_Id = std.Student_Id,
                                                                   Test_Name = std.Test.Test_Name,
                                                                   Total_Marks = std.Test.Total_Makrs,
                                                                   Marks_Obtained = (double)
                                                                   (from StudentTestDetail in _lmsDbContext.StudentTestDetail
                                                                    where StudentTestDetail.Test_Id == std.Test_Id
                                                                    select new
                                                                    {
                                                                        StudentTestDetail.Marks_Obtained
                                                                    }).Sum(p => p.Marks_Obtained),
                                                                   Grade_Name =
                                                                   ((from Grade in _lmsDbContext.Grade
                                                                     where
                                                                    (from StudentTestDetail in _lmsDbContext.StudentTestDetail
                                                                     where StudentTestDetail.Test_Id == std.Test_Id
                                                                     select new
                                                                     {
                                                                         StudentTestDetail.Marks_Obtained
                                                                     }).Sum(p => p.Marks_Obtained) >= Grade.Start_From &&
                                                                    (from StudentTestDetail in _lmsDbContext.StudentTestDetail
                                                                     where StudentTestDetail.Test_Id == std.Test_Id
                                                                     select new
                                                                     {
                                                                         StudentTestDetail.Marks_Obtained
                                                                     }).Sum(p => p.Marks_Obtained) <= Grade.End_On
                                                                     select new
                                                                     {
                                                                         Grade.Grade_Name
                                                                     }).Take(1).First().Grade_Name)
                                                               }).Distinct();

            return Student;
        }
    }
}
