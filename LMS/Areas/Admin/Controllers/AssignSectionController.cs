using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/assignSection")]

    public class AssignSectionController : Controller
    {
        private readonly IAssignSectionRepository _AssignSectionRepository;

        public AssignSectionController(IAssignSectionRepository AssignSectionRepository)
        {
            _AssignSectionRepository = AssignSectionRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            
            var ClassSection = _AssignSectionRepository.GetAllClasSection();
            
            ViewBag.Class = _AssignSectionRepository.GetAllClass();

            ViewBag.Section = _AssignSectionRepository.GetAllSection();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }


            return View(ClassSection);
        }


        [HttpPost]
        [Route("addClassSection")]
        public async Task<IActionResult> AddClassSection(AssignSectionViewModel objClassSection)
        {
            if (ModelState.IsValid)
            {
                ClassSection newClassSection = new ClassSection
                {
                    Class_Id = objClassSection.Class_Id,
                    Section_Id = objClassSection.Section_Id
                };

                int result =  await _AssignSectionRepository.AddClassSection(newClassSection);
                if (result == 1)
                {
                    TempData["Success"] = "Assign Section To Class Successfully";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Assign Section To Class Failed";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }
                

            }

            return View();
        }


        [HttpGet]
        [Route("editClassSection/{id}")]
        public async Task<IActionResult> EditClassSection(int id)
        {


            ViewBag.Class = _AssignSectionRepository.GetAllClass();

            ViewBag.Section = _AssignSectionRepository.GetAllSection();

            var objassignSection = await _AssignSectionRepository.GetClassSectionById(id);

            return new JsonResult(objassignSection);

        }


        [HttpPost]
        [Route("editClassSection")]
        public async Task<IActionResult> EditClassSection(AssignSectionViewModel objClassSection)
        {
            if (ModelState.IsValid)
            {
                ClassSection objAssignSection = await _AssignSectionRepository.GetClassSectionById(objClassSection.ClassSection_Id);

                objAssignSection.Class_Id = objClassSection.Class_Id;
                objAssignSection.Section_Id = objClassSection.Section_Id;


                int result = await _AssignSectionRepository.UpdateClassSection(objAssignSection);

                if (result == 1)
                {
                    TempData["Success"] = "Class Section Updted Successfully";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updting Class Section Failed";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }

            }

            return View();
        }


        [HttpPost]
        [Route("deleteClassSection")]
        public async Task<IActionResult> DeleteClassSection(int ClassSection_Id)
        {

            if (ModelState.IsValid)
            {
                int result = await _AssignSectionRepository.DeleteClassSection(ClassSection_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Class Section Deteled Successfully";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Class Section Failed";
                    return RedirectToAction("Index", "assignSection", new { area = "admin" });
                }
            }

            return View();
             
        }

    }
}