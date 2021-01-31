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
    [Route("students/progressReport")]
    public class ProgressReportController : Controller
    {
        private readonly ISPProgressReportRepository _StudentProgressReportRepository;

        public ProgressReportController(ISPProgressReportRepository StudentProgressReportRepository)
        {
            _StudentProgressReportRepository = StudentProgressReportRepository;
        }

       
        [Route("progressReport")]
        public IActionResult ProgressReport()
        {
            string StartDate = "01010101";
            string EndDate = "01010102";
            int StudentId = HttpContext.Session.GetInt32("UserId") ?? 0;

            var ProgressReport = _StudentProgressReportRepository.GetProgressReportByStudentId($@"EXEC spGetStudentProgressReportByStudentId '" + StudentId + "','" + StartDate + "','" + EndDate + "'");

            

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(ProgressReport);
        }


        [HttpGet]
        [Route("progressReport")]
        public IActionResult ProgressReport(string StartDate, string EndDate)
        {
            string sDate = Convert.ToDateTime(StartDate).ToString("yyyyMMdd");
            string eDate = Convert.ToDateTime(EndDate).ToString("yyyyMMdd");
            int StudentId = HttpContext.Session.GetInt32("UserId") ?? 0;

            var ProgressReport = _StudentProgressReportRepository.GetProgressReportByStudentId($@"EXEC spGetStudentProgressReportByStudentId '" + StudentId + "','" + StartDate + "','" + EndDate + "'");

            ViewBag.StartDate = StartDate;
            ViewBag.EndDate = EndDate;

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View("ProgressReport", ProgressReport);
        }

    }
}