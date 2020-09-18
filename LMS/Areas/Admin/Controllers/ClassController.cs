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


        [HttpPost]
        [Route("addClass")]
        public async Task<IActionResult> AddClass(Class objClass)
        {
            if (ModelState.IsValid)
            {
                Class newClass = new Class
                {
                    Class_Name = objClass.Class_Name
                };

                await _ClassRepository.AddClass(newClass);

                return RedirectToAction("Index", "class", new { area = "admin" });

            }

            return View();
        }


        [HttpPost]
        [Route("deleteClass")]
        public async Task<IActionResult> DeleteClass(int Class_Id)
        {
                await _ClassRepository.DeleteClass(Class_Id);

                return RedirectToAction("Index", "class", new { area = "admin" });
            
        }



        [HttpGet]
        [Route("editClass/{id}")]
        public async Task<IActionResult> EditClass(int id)
        {
            var objClass =  await _ClassRepository.GetClassById(id);

            return new JsonResult(objClass);

        }



        [HttpPost]
        [Route("editClass")]
        public async Task<IActionResult> EditClass(Class classModel)
        {
            if (ModelState.IsValid)
            {
                Class objClass = await _ClassRepository.GetClassById(classModel.Class_Id);

                objClass.Class_Name = classModel.Class_Name;

                await _ClassRepository.UpdateClass(objClass);

                return RedirectToAction("Index", "class", new { area = "admin" });

            }

            return View();
        }


    }
}