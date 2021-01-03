using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.ViewComponents
{
    [ViewComponent(Name = "TPSidebar")]
    public class TPSidebarViewComponent : ViewComponent
    {
        private readonly ITPClassRepository _tPClassRepository;

        public TPSidebarViewComponent(ITPClassRepository tPClassRepository)
        {
            _tPClassRepository = tPClassRepository;

        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var TeacherClasses = _tPClassRepository.GetTeacherClassSubjectstDistinctByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0);

            return View("TPSidebarVC", TeacherClasses);
        }
    }
}
