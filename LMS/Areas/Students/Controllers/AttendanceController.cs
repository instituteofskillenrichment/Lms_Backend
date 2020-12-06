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
    [Route("students/attendance")]
    public class AttendanceController : Controller
    {
        private readonly ISPStudentAttendanceRepository _StudentAttendanceRepository;

        public AttendanceController(ISPStudentAttendanceRepository StudentAttendanceRepository)
        {
            _StudentAttendanceRepository = StudentAttendanceRepository;
        }

        [Route("attendances")]
        public async Task<IActionResult> Attendances()
        {
            var Attendance = await _StudentAttendanceRepository.GetAllAttendance(HttpContext.Session.GetInt32("UserId") ?? 0);

            return View(Attendance);
        }
    }
}