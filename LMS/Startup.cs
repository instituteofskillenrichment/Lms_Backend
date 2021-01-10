using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using LMS.Database;
using LMS.BusinessLogics.Interfaces;
using LMS.BusinessLogics.Repositories;
using LMS.Domain.ViewModels;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authentication.Cookies;

namespace LMS
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDistributedMemoryCache();
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(600);
            });
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });


            services.ConfigureApplicationCookie(options =>
            {
                // Cookie settings
                options.Cookie.HttpOnly = true;
                options.ExpireTimeSpan = TimeSpan.FromMinutes(5);

                //options.LoginPath = "/Login/Index"; // Set here your login path.

                options.SlidingExpiration = true;

            });



            services.AddDbContext<LmsDbContext>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("DefaultConnection")));

            //services.AddDefaultIdentity<IdentityUser>().AddEntityFrameworkStores<LmsDbContext>();
            //added By absar
            services.AddIdentity<IdentityUser, IdentityRole>()
                .AddEntityFrameworkStores<LmsDbContext>()
                .AddDefaultTokenProviders();



            services.PostConfigure<CookieAuthenticationOptions>(IdentityConstants.ApplicationScheme, opt =>
            {
                //configure your other properties
                opt.LoginPath = "/Login/Index";
            });


            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
            services.AddLogging();
            //Added By Absar
            services.AddScoped<IClassRepository, ClassRepository>();
            services.AddScoped<ITeacherRepository, TeacherRepository>();
            services.AddScoped<ITeacherSubjectRepository, TeacherSubjectRepository>();
            services.AddScoped<IStudentRepository, StudentRepository>();
            services.AddScoped<IStudentClassRepository, StudentClassRepository>();
            services.AddScoped<ISectionRepository, SectionRepository>();
            services.AddScoped<IRoleRepository, RoleRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IAssignSectionRepository, AssignSectionRepository>();
            services.AddScoped<IAssignSubjectRepository, AssignSubjectRepository>();
            services.AddScoped<ISubjectRepository, SubjectRepository>();
            services.AddScoped<ILectureRepository, LectureRepository>();
            services.AddScoped<IGradeRepository, GradeRepository>();
            services.AddScoped<ITeacherTestRepository, TeacherTestRepository>();
            services.AddScoped<ITPClassRepository, TPClassRepository>();
            services.AddScoped<IStudentTestRepository, StudentTestRepository>();
            services.AddScoped<ITPAttendanceRepository, TPAttendanceRepository>();
            services.AddScoped<IAnnouncementReporitory, AnnouncementReporitory>();
            services.AddScoped<ISPStudentClassSubjectRepository, SPStudentClassSubjectRepository>();
            services.AddScoped<ISPSubjectLectureRepository, SPSubjectLectureRepository>();
            services.AddScoped<ISPAnnouncementRepository, SPAnnouncementRepository>();
            services.AddScoped<ISPStudentAttendanceRepository, SPStudentAttendanceRepository>();
            services.AddScoped<ILibraryRepository, LibraryRepository>();
            services.AddScoped<ITeacherGradeRepository, TeacherGradeRepository>();

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();


            app.UseAuthentication();
            app.UseSession();
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Login}/{action=Index}/{id?}");
            });
            app.UseCookiePolicy();
            //app.UseMvc(routes =>
            //{
            //    routes.MapRoute(
            //      name: "areas",
            //      template: "Admin/{controller=Dashboard}/{action=Index}/{id?}"
            //    );
            //});
        }
    }
}
