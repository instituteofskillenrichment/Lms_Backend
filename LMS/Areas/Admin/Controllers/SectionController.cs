using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/section")]
    public class SectionController : Controller
    {
        private readonly ISectionRepository _SectionRepository;

        public SectionController(ISectionRepository SectionRepository)
        {
            _SectionRepository = SectionRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Section = _SectionRepository.GetAllSection();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }


            return View(Section);
        }


        [HttpPost]
        [Route("addSection")]
        public async Task<IActionResult> AddSection(Section objSection)
        {
            if (ModelState.IsValid)
            {
                Section newSection = new Section
                {
                    Section_Name = objSection.Section_Name.ToUpper()
                };

                int result = await _SectionRepository.AddSection(newSection);
                if (result == 1)
                {
                    TempData["Success"] = "Section Added Successfully";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Section Added Failed";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }

                

            }

            return View();
        }



        [HttpGet]
        [Route("editSection/{id}")]
        public async Task<IActionResult> EditSection(int id)
        {
            var objSection = await _SectionRepository.GetSectionById(id);

            return new JsonResult(objSection);

        }


        [HttpPost]
        [Route("editSection")]
        public async Task<IActionResult> EditSection(Section sectionModel)
        {
            if (ModelState.IsValid)
            {
                Section objSection = await _SectionRepository.GetSectionById(sectionModel.Section_Id);

                objSection.Section_Name = sectionModel.Section_Name;

                int result = await _SectionRepository.UpdateSection(objSection);

                if (result == 1)
                {
                    TempData["Success"] = "Section Updated Successfully";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updating Section Failed";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }

            }

            return View();
        }


        [HttpPost]
        [Route("deleteSection")]
        public async Task<IActionResult> DeleteSection(int Section_Id)
        {
            if (ModelState.IsValid)
            {
               int result = await _SectionRepository.DeleteSection(Section_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Section Deleted Successfully";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Section Failed";
                    return RedirectToAction("Index", "section", new { area = "admin" });
                }
                

            }

            return View();   

        }

    }
}