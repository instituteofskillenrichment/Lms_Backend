using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Teachers.Controllers
{
    [Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/announcement")]
    public class AnnouncementController : Controller
    {
        private readonly IAnnouncementReporitory _AnnouncementRepository;
        private readonly ILectureRepository _LectureRepository;

        public AnnouncementController(IAnnouncementReporitory AnnouncementRepository, ILectureRepository LectureRepository)
        {
            _AnnouncementRepository = AnnouncementRepository;
            _LectureRepository = LectureRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var announcementVM = new AnnouncementViewModel();
            announcementVM.Announcement = _AnnouncementRepository.GetAnnouncementtByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();

            announcementVM.Classes = new List<SelectListItem>();
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                announcementVM.Classes.Add(selectListItem);
            }


            announcementVM.Sections = new List<SelectListItem>();
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                announcementVM.Sections.Add(selectListItem);
            }


            announcementVM.Subjects = new List<SelectListItem>();
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                announcementVM.Subjects.Add(selectListItem);
            }



            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(announcementVM);
        }


        [HttpPost]
        [Route("addAnnouncement")]
        public async Task<IActionResult> addAnnouncement(AnnouncementViewModel objAnnouncement)
        {
            if (ModelState.IsValid)
            {
                Announcement newAnnouncement = new Announcement
                {
                    Announcement_Detail = objAnnouncement.Announcement_Detail,
                    Announcement_Date = objAnnouncement.Announcement_Date.ToString("yyyyMMdd"),
                    Class_Id = objAnnouncement.Class_Id,
                    Section_Id = objAnnouncement.Section_Id,
                    Subject_Id = objAnnouncement.Subject_Id,
                    Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 0
                };

                int result = await _AnnouncementRepository.AddAnnouncement(newAnnouncement);
                if (result == 1)
                {
                    TempData["Success"] = " Announcement Added Successfully";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Adding Announcement Failed";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }



            }

            return View();
        }



        [HttpPost]
        [Route("deleteAnnouncement")]
        public async Task<IActionResult> DeleteAnnouncement(int Announcement_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _AnnouncementRepository.DeleteAnnouncement(Announcement_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Delete Announcement Successfully";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Deleting Announcement Failed";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }
            }

            return View();

        }


        [HttpGet]
        [Route("editAnnouncement/{id}")]
        public async Task<IActionResult> EditAnnouncement(int id)
        {
            var objAnnouncement = await _AnnouncementRepository.GetAnnouncementById(id);

            return new JsonResult(objAnnouncement);

        }


        [HttpPost]
        [Route("editAnnouncement")]
        public async Task<IActionResult> EditAnnouncement(AnnouncementViewModel announcementModel)
        {
            if (ModelState.IsValid)
            {
                Announcement objAnnouncement = await _AnnouncementRepository.GetAnnouncementById(announcementModel.Announcement_Id);

                objAnnouncement.Announcement_Detail = announcementModel.Announcement_Detail;
                objAnnouncement.Announcement_Date = announcementModel.Announcement_Date.ToString("yyyyMMdd");
                objAnnouncement.Class_Id = announcementModel.Class_Id;
                objAnnouncement.Section_Id = announcementModel.Section_Id;
                objAnnouncement.Subject_Id = announcementModel.Subject_Id;

                int result = await _AnnouncementRepository.UpdateAnnouncement(objAnnouncement);

                if (result == 1)
                {
                    TempData["Success"] = "Announcement Updated Successfully";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Updating Announcement Failed ";
                    return RedirectToAction("Index", "announcement", new { area = "teachers" });
                }

            }

            return View();
        }
    }
}