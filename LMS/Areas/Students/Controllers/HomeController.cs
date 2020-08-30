using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Students.Controllers
{
    [Area("students")]
    [Route("students/home")]
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}