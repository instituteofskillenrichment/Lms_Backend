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
    [Route("admin/subject")]
    public class SubjectController : Controller
    {
        private readonly ISubjectRepository _SubjectRepository;

        public SubjectController(ISubjectRepository SubjectRepository)
        {
            _SubjectRepository = SubjectRepository;
        }



        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Subject = _SubjectRepository.GetAllSubject();

            return View(Subject);
        }


        [HttpPost]
        [Route("addSubject")]
        public async Task<IActionResult> AddSubject(Subject objSubject)
        {
            if (ModelState.IsValid)
            {
                Subject newSubject = new Subject
                {
                    Subject_Name = objSubject.Subject_Name
                };

                await _SubjectRepository.AddSubject(newSubject);

                return RedirectToAction("Index", "subject", new { area = "admin" });

            }

            return View();
        }


        [HttpGet]
        [Route("editSubject/{id}")]
        public async Task<IActionResult> EditSubject(int id)
        {
            var objSubject = await _SubjectRepository.GetSubjectById(id);

            return new JsonResult(objSubject);

        }


        [HttpPost]
        [Route("editSubject")]
        public async Task<IActionResult> EditSubject(Subject subjectModel)
        {
            if (ModelState.IsValid)
            {
                Subject objSubject = await _SubjectRepository.GetSubjectById(subjectModel.Subject_Id);

                objSubject.Subject_Name = subjectModel.Subject_Name;

                await _SubjectRepository.UpdateSubject(objSubject);

                return RedirectToAction("Index", "subject", new { area = "admin" });

            }

            return View();
        }



        [HttpPost]
        [Route("deleteSubject")]
        public async Task<IActionResult> DeleteSubject(int Subject_Id)
        {
            await _SubjectRepository.DeleteSubject(Subject_Id);

            return RedirectToAction("Index", "subject", new { area = "admin" });

        }
    }
}