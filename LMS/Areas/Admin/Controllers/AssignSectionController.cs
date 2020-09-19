using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Admin.Controllers
{
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

            //var assignSectionVM = new AssignSectionViewModel()
            //{
            //    assignSectionViewModels = ClassSection
            //};


            ViewBag.Class = _AssignSectionRepository.GetAllClass();

            ViewBag.Section = _AssignSectionRepository.GetAllSection();

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
                    Class_Id = objClassSection.ClassId,
                    Section_Id = objClassSection.SectionId
                };

                await _AssignSectionRepository.AddClassSection(newClassSection);

                return RedirectToAction("Index", "assignSection", new { area = "admin" });

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

                objAssignSection.Class_Id = objClassSection.ClassId;
                objAssignSection.Section_Id = objClassSection.SectionId;


                await _AssignSectionRepository.UpdateClassSection(objAssignSection);

                return RedirectToAction("Index", "assignSection", new { area = "admin" });

            }

            return View();
        }


        [HttpPost]
        [Route("deleteClassSection")]
        public async Task<IActionResult> DeleteClassSection(int ClassSection_Id)
        {
            await _AssignSectionRepository.DeleteClassSection(ClassSection_Id);

            return RedirectToAction("Index", "assignSection", new { area = "admin" });

        }

    }
}