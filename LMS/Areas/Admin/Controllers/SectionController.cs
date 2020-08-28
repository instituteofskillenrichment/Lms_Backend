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
                    Section_Name = objSection.Section_Name
                };

                await _SectionRepository.AddSection(newSection);

                return RedirectToAction("Index", "section", new { area = "admin" });

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

                await _SectionRepository.UpdateSection(objSection);

                return RedirectToAction("Index", "section", new { area = "admin" });

            }

            return View();
        }


        [HttpPost]
        [Route("deleteSection")]
        public async Task<IActionResult> DeleteSection(int Section_Id)
        {
            await _SectionRepository.DeleteSection(Section_Id);

            return RedirectToAction("Index", "section", new { area = "admin" });

        }

    }
}