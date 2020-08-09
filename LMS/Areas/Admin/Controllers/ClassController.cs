using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/class")]
    public class ClassController : Controller
    {
        private readonly IClassRepository _ClassRepository;

        public ClassController(IClassRepository ClassRepository)
        {
            _ClassRepository = ClassRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Class = _ClassRepository.GetAllClass();

            return View(Class);
        }
    }
}