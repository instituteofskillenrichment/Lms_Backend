using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Teachers.Controllers
{
    [Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/dashboard")]
    public class DashboardController : Controller
    {
        private readonly ITPClassRepository _tPClassRepository;
        private readonly ILectureRepository _LectureRepository;
        private readonly ITPAttendanceRepository _tPAttendanceRepository;
        private readonly IAnnouncementReporitory _AnnouncementRepository;

        public DashboardController(ITPClassRepository tPClassRepository, ILectureRepository LectureRepository, ITPAttendanceRepository tPAttendanceRepository, IAnnouncementReporitory AnnouncementRepository)
        {
            _tPClassRepository = tPClassRepository;
            _LectureRepository = LectureRepository;
            _tPAttendanceRepository = tPAttendanceRepository;
            _AnnouncementRepository = AnnouncementRepository;

        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var TeacherClasses = _tPClassRepository.GetTeacherClassSubjectstDistinctByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0);
            ViewBag.Classes = TeacherClasses.Count();

            var TeacherSubjects = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            ViewBag.Subjects = TeacherSubjects.Count();

            var TeacherStudents = _tPAttendanceRepository.GetAllStudentsClass(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            ViewBag.Students = TeacherStudents.Count();
            
            
            var Announcements = _AnnouncementRepository.GetAllAnnouncement(); ;
            ViewBag.Announcements = Announcements;

            var RecentLecture = _LectureRepository.GetRecentLecture(); ;
            ViewBag.RecentLecture = RecentLecture;

            return View();
        }
    }
}