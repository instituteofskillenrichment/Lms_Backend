using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Students.Controllers
{
    [Authorize(Roles = "Student")]
    [Area("students")]
    [Route("students/dashboard")]
    public class DashboardController : Controller
    {
        private readonly IAnnouncementReporitory _AnnouncementRepository;
        private readonly ILectureRepository _LectureRepository;
        private readonly IStudentClassRepository _StudentClassRepository;
        private readonly ISPSubjectLectureRepository _SPSubjectLecture;

        public DashboardController(ISPSubjectLectureRepository SPSubjectLecture, IStudentClassRepository StudentClassRepository, IAnnouncementReporitory AnnouncementRepository, ILectureRepository LectureRepository)
        {
            _AnnouncementRepository = AnnouncementRepository;
            _LectureRepository = LectureRepository;
            _StudentClassRepository = StudentClassRepository;
            _SPSubjectLecture = SPSubjectLecture;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Assessments = _StudentClassRepository.GetTestsByStudentId(HttpContext.Session.GetInt32("UserId") ?? 0);
            ViewBag.Assessments = Assessments.Count();

            

            var Announcements = _AnnouncementRepository.GetAllAnnouncement(); ;
            ViewBag.Announcements = Announcements;

            var RecentLecture = _LectureRepository.GetRecentLecture(); ;
            ViewBag.RecentLecture = RecentLecture;

            return View();
        }
    }
}