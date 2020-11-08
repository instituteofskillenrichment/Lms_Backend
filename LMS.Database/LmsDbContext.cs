using LMS.Domain;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

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
        public DbSet<Session> Session { get; set; }
        public DbSet<Attendance> Attendance { get; set; }




    }
}
