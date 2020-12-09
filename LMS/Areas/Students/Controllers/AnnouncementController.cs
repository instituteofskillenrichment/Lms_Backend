using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Students.Controllers
{
    [Authorize(Roles = "Student")]
    [Area("students")]
    [Route("students/announcement")]
    public class AnnouncementController : Controller
    {
        private readonly ISPAnnouncementRepository _AnnouncementRepository;

        public AnnouncementController(ISPAnnouncementRepository AnnouncementRepository)
        {
            _AnnouncementRepository = AnnouncementRepository;
        }

        [Route("announcements")]
        public async Task<IActionResult> Announcements(int ClassSection_Id)
        {
            var Announcement = await _AnnouncementRepository.GetAllAnnouncement(ClassSection_Id);

            return View(Announcement);
        }


        [HttpGet]
        [Route("viewAnnouncement/{id}")]
        public async Task<IActionResult> ViewAnnouncement(int id)
        {
            var objAnnouncement = await _AnnouncementRepository.GetAnnouncementById(id);

            return new JsonResult(objAnnouncement);

        }
    }
}