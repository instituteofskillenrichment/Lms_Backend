using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Students.Controllers
{
    [Authorize(Roles = "Student")]
    [Area("students")]
    [Route("students/dashboard")]
    public class DashboardController : Controller
    {

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            return View();
        }
    }
}