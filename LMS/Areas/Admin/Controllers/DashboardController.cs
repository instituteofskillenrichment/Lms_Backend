using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{

    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/dashboard")]
    public class DashboardController : Controller
    {
        private readonly ITeacherRepository _TeacherRepository;
        private readonly IStudentRepository _StudentRepository;
        private readonly IClassRepository _ClassRepository;
        private readonly IAnnouncementReporitory _AnnouncementRepository;
        private readonly ILibraryRepository _LibraryRepository;

        public DashboardController(ITeacherRepository TeacherRepository, IStudentRepository StudentRepository, IClassRepository ClassRepository, IAnnouncementReporitory AnnouncementRepository, ILibraryRepository LibraryRepository)
        {
            _TeacherRepository = TeacherRepository;
            _StudentRepository = StudentRepository;
            _ClassRepository = ClassRepository;
            _AnnouncementRepository = AnnouncementRepository;
            _LibraryRepository = LibraryRepository;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Teachers= _TeacherRepository.GetAllTeacher();
            ViewBag.Teachers = Teachers.Count();

            var Students = _StudentRepository.GetAllStudent();
            ViewBag.Students = Students.Count();

            var Classes = _ClassRepository.GetAllClass();
            ViewBag.Classes = Classes.Count();

            var Announcements = _AnnouncementRepository.GetAllAnnouncement(); ;
            ViewBag.Announcements = Announcements;

            var RecentPost = _LibraryRepository.GetAllRecentBooks(); ;
            ViewBag.RecentPost = RecentPost;

            return View();
        }
    }
}