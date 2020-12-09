using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Teachers.Controllers
{
    //[Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/dashboard")]
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