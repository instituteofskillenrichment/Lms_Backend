using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace LMS.Database
{
    public class LmsDbContext : IdentityDbContext
    {
        public LmsDbContext(DbContextOptions<LmsDbContext> options)
                : base(options) { }

        public DbSet<Class> Class { get; set; }
        public DbSet<Section> Section { get; set; }
        public DbSet<ClassSection> ClassSection { get; set; }
        public DbSet<Subject> Subject { get; set; }
        public DbSet<ClassSubject> ClassSubject { get; set; }
        public DbSet<Teacher> Teacher { get; set; }
        public DbSet<TeacherSubject> TeacherSubject { get; set; }
        public DbSet<Student> Student { get; set; }
        public DbSet<StudentClass> StudentClass { get; set; }
        public DbSet<Lecture> Lecture { get; set; }
        public DbSet<Grade> Grade { get; set; }
        public DbSet<Test> Test { get; set; }
        public DbSet<TestDetail> TestDetail { get; set; }
        public DbSet<TestType> TestType { get; set; }
        public DbSet<Session> Session { get; set; }
        public DbSet<Attendance> Attendance { get; set; }

        public DbSet<StudentTestDetail> StudentTestDetail { get; set; }
		public DbSet<AssessmentType> AssessmentType { get; set; }
        public DbSet<Announcement> Announcement { get; set; }
        public DbSet<BookCategory> BookCategory { get; set; }
        public DbSet<Library> Library { get; set; }

        //[NotMapped]
        public DbQuery<SpStudentGradeBySubjectId> SpStudentGradeBySubjectId { get; set; }  //Calling SP Added By Absar
        public DbQuery<SpStudentGradeByTestId> SpStudentGradeByTestId { get; set; }  //Calling SP Added By Absar
        public DbQuery<SpProgressReportByStudentId> SpProgressReportByStudentId { get; set; }  //Calling SP Added By Absar
        public DbQuery<SpProgressReportByClassSectionId> SpProgressReportByClassSectionId { get; set; }  //Calling SP Added By Absar



        

    }
}
