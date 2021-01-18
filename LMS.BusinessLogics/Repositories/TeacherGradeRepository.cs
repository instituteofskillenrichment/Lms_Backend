using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class TeacherGradeRepository : ITeacherGradeRepository
    {

        private LmsDbContext _lmsDbContext;
        //private DbQuery<SpStudentGradeBySubjectId> databaseSet;

        public TeacherGradeRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
            //databaseSet = _lmsDbContext.<SpStudentGradeBySubjectId>();
        }

        //public async Task<IQueryable<SpStudentGradeBySubjectId>> GetAllStudentsBySubjectId(int SubjectId)
        //{
           

        //    try
        //    { 
        //        SqlParameter[] param = new SqlParameter[]
        //        {
        //            new SqlParameter ("@ClassSubjectId", SubjectId),
        //            new SqlParameter ("@StartDate", "20210101"),
        //            new SqlParameter ("@EndDate", "20210131")
        //        };


        //        IQueryable<SpStudentGradeBySubjectId> AllStudentsGrades =   _lmsDbContext.Query<SpStudentGradeBySubjectId>().FromSql("spGetStudentGradeBySubjectId @ClassSubjectId,@StartDate,@EndDate", param).AsQueryable();

        //        //var abc = _lmsDbContext.spGetStudentGradeBySubjectId
        //        // .FromSql("spGetStudentGradeBySubjectId @ClassSubjectId, @StartDate, @EndDate",
        //        //        param)
        //        //  .ToList();

        //        IQueryable<SpStudentGradeBySubjectId> ClassSection = AllStudentsGrades.AsQueryable();

        //        return ClassSection;
        //    }
        //    catch(Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public IQueryable<SpStudentGradeByTestId> GetStudentsAllTestResults(string StudentId)
        {
            //IEnumerable<StudentTestDetailViewModel> Student = (from std in _lmsDbContext.StudentTestDetail
            //                                                   where std.Student_Id == StudentId
            //                                                   select new StudentTestDetailViewModel()
            //                                                   {
            //                                                       Student_Id = std.Student_Id,
            //                                                       Test_Name = std.Test.Test_Name,
            //                                                       Total_Marks = std.Test.Total_Makrs,
            //                                                       Marks_Obtained = (double)
            //                                                       (from StudentTestDetail in _lmsDbContext.StudentTestDetail
            //                                                        where StudentTestDetail.Test_Id == std.Test_Id
            //                                                        select new
            //                                                        {
            //                                                            StudentTestDetail.Marks_Obtained
            //                                                        }).Sum(p => p.Marks_Obtained),
            //                                                       Grade_Name =
            //                                                       ((from Grade in _lmsDbContext.Grade
            //                                                         where
            //                                                        (from StudentTestDetail in _lmsDbContext.StudentTestDetail
            //                                                         where StudentTestDetail.Test_Id == std.Test_Id
            //                                                         select new
            //                                                         {
            //                                                             StudentTestDetail.Marks_Obtained
            //                                                         }).Sum(p => p.Marks_Obtained) >= Grade.Start_From &&
            //                                                        (from StudentTestDetail in _lmsDbContext.StudentTestDetail
            //                                                         where StudentTestDetail.Test_Id == std.Test_Id
            //                                                         select new
            //                                                         {
            //                                                             StudentTestDetail.Marks_Obtained
            //                                                         }).Sum(p => p.Marks_Obtained) <= Grade.End_On
            //                                                         select new
            //                                                         {
            //                                                             Grade.Grade_Name
            //                                                         }).Take(1).First().Grade_Name)
            //                                                   }).Distinct();



            //IEnumerable<StudentTestDetailViewModel> Student = (
            //                                                    from sdu in _lmsDbContext.Student
            //                                                    join scl in _lmsDbContext.StudentClass on sdu.Student_Id equals scl.Student_Id
            //                                                    join csub in _lmsDbContext.ClassSubject on scl.ClassSection_id equals csub.ClassSection_Id
            //                                                    join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
            //                                                    join sec in _lmsDbContext.Section on csec.Section_Id equals sec.Section_Id
            //                                                    join cl in _lmsDbContext.Class on csec.Class_Id equals cl.Class_Id
            //                                                    join std in _lmsDbContext.StudentTestDetail on scl.Student_Id equals std.Student_Id
            //                                                    join td in _lmsDbContext.TestDetail on std.Test_Id equals td.Test_Id
            //                                                    join tst in _lmsDbContext.Test on td.Test_Id equals tst.Test_Id
            //                                                    join tsub in _lmsDbContext.TeacherSubject on tst.Teacher_Id equals tsub.Teacher_Id
            //                                                    where 
            //                                                    csub.ClassSubject_Id == ClassSubjectId
            //                                                    && sdu.Student_Id == StudentId
            //                                                    && (Convert.ToInt32(tst.Assessment_Date)  >= Convert.ToInt32(StartDate) && Convert.ToInt32(tst.Assessment_Date) <= Convert.ToInt32(EndDate))
            //                                                    && csec.Class_Id == tst.Class_Id
            //                                                    && csec.Section_Id == tst.Section_Id
            //                                                    && csub.Subject_Id == tst.Subject_Id
            //                                                    group new { std, tst, td, tsub, scl } by new
            //                                                    {
            //                                                        std.Student_Id,
            //                                                        sdu.Student_Name,
            //                                                        tst.Total_Makrs,
            //                                                        tst.Weighatge,
            //                                                        td.Test_Id,
            //                                                        td.Question_Id,
            //                                                        tsub.ClassSubject_Id,
            //                                                        scl.StudentClass_Id,
            //                                                        tst.Class_Id,
            //                                                        tst.Section_Id,
            //                                                        tst.Subject_Id
            //                                                    } into g
            //                                                    select new StudentTestDetailViewModel
            //                                                    {
            //                                                        Student_Id = g.Key.Student_Id,
            //                                                        Student_Name = g.Key.Student_Name,
            //                                                        Total_Marks = g.Sum(t => t.tst.Total_Makrs),
            //                                                        Marks_Obtained = g.Sum(m =>m.std.Marks_Obtained),
            //                                                        Total_Weightage = g.Select(w => w.tst.Weighatge).Distinct().Sum(),
            //                                                        Weightage_Score = ((double)(g.Sum(p => p.std.Marks_Obtained) / Convert.ToDecimal(g.Key.Total_Makrs)) * g.Select(p => p.td.Test.Weighatge).Distinct().Sum()),
            //                                                        Class_Id = g.Key.Class_Id,
            //                                                        Section_Id = g.Key.Section_Id,
            //                                                        Subject_Id = g.Key.Subject_Id

            //                                                    }
            //                                                  ).Distinct();

            return _lmsDbContext.SpStudentGradeByTestId.FromSql(StudentId);
            //return Student;
        }

        public IQueryable<SpStudentGradeBySubjectId> RunSql(string SubjectId)
        {


            //var agentsPartner = _lmsDbContext.Get<SpStudentGradeBySubjectId>().RunSql($@"EXEC spGetAgentsPartner { SubjectId }");

            return _lmsDbContext.SpStudentGradeBySubjectId.FromSql(SubjectId);
        }
    }
}
