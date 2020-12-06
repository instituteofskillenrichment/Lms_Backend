using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.ViewComponents
{
    [ViewComponent(Name = "SPSidebar")]
    public class SPSidebarViewComponent : ViewComponent
    {
        private readonly ISPStudentClassSubjectRepository _StudentClassSubject;

        public SPSidebarViewComponent(ISPStudentClassSubjectRepository StudentClassSubject)
        {
            _StudentClassSubject = StudentClassSubject;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var StudentSubjects = _StudentClassSubject.GetStudentClassSubjectstDistinctByStudentId(HttpContext.Session.GetInt32("UserId") ?? 0);

            

            return View("SPSidebarVC", StudentSubjects);
        }
    }
}
