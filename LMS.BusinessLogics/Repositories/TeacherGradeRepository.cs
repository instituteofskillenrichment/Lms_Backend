using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
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
                                                              join g in _lmsDbContext.Grade on cs.Subject_Id equals g.Subject_Id into g_join
                                                              from g in g_join.DefaultIfEmpty()
                                                              where cs.Subject_Id == SubjectId
                                                              group new { s, t, std, g } by new
                                                              {
                                                                  s.Student_Id,
                                                                  s.Student_Name,
                                                                  t.Total_Makrs,
                                                                  std.Marks_Obtained,
                                                                  g.Grade_Name
                                                              } into g
                                                              select new StudentGradeViewModel
                                                              {
                                                                  Student_Id = (int)g.Key.Student_Id,
                                                                  Student_Name = g.Key.Student_Name,
                                                                  Total_Marks = (double?)g.Sum(p => p.t.Total_Makrs),
                                                                  Obtained_Marks = (double?)g.Sum(p => p.std.Marks_Obtained),
                                                                  Grade = g.Key.Grade_Name
                                                              }).Distinct();

            return AllStudents;
        }

        public IEnumerable<StudentTestDetailViewModel> GetStudentsAllTestResults(int StudentId)
        {
            throw new System.NotImplementedException();
        }
    }
}
