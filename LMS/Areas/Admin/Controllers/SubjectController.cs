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

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

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

                int result =  await _SubjectRepository.AddSubject(newSubject);
                if (result == 1)
                {
                    TempData["Success"] = "Subject Added Successfully";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Subject Adding Failed";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }
                

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

                int result = await _SubjectRepository.UpdateSubject(objSubject);

                if (result == 1)
                {
                    TempData["Success"] = "Subject Updated Successfully";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updating Subject Failed";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }

            }

            return View();
        }



        [HttpPost]
        [Route("deleteSubject")]
        public async Task<IActionResult> DeleteSubject(int Subject_Id)
        {
            if (ModelState.IsValid)
            { 
                int result = await _SubjectRepository.DeleteSubject(Subject_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Subject Deleted Successfully";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deletiing Subject Failed";
                    return RedirectToAction("Index", "subject", new { area = "admin" });
                }

            }

            return View();
        }
    }
}