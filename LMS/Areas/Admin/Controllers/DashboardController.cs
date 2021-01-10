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

        public DashboardController(ITeacherRepository TeacherRepository, IStudentRepository StudentRepository)
        {
            _TeacherRepository = TeacherRepository;
            _StudentRepository = StudentRepository;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Teachers= _TeacherRepository.GetAllTeacher();
            ViewBag.Teachers = Teachers.Count();

            var Students = _StudentRepository.GetAllStudent();
            ViewBag.Students = Students.Count();

            return View();
        }
    }
}