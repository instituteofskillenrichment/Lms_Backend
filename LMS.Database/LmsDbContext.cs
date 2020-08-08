using LMS.Domain;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

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

        
    }
}
