using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Teachers.Controllers
{
    [Area("teachers")]
    [Route("teachers/home")]
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}