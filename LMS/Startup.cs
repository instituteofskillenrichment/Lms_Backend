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
            services.Configure<CookiePolicyOptions>(options =>
            {
                // This lambda determines whether user consent for non-essential cookies is needed for a given request.
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
            });

            services.AddDbContext<LmsDbContext>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("DefaultConnection")));

            //services.AddDefaultIdentity<IdentityUser>().AddEntityFrameworkStores<LmsDbContext>();
            //added By absar
            services.AddIdentity<IdentityUser, IdentityRole>()
                .AddEntityFrameworkStores<LmsDbContext>()
                .AddDefaultTokenProviders();


            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);

            //Added By Absar
            services.AddScoped<IClassRepository, ClassRepository>();
            services.AddScoped<ISectionRepository, SectionRepository>();
            services.AddScoped<IRoleRepository, RoleRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IAssignSectionRepository, AssignSectionRepository>();
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
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseCookiePolicy();

            app.UseAuthentication();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Login}/{action=Index}/{id?}");
            });
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
