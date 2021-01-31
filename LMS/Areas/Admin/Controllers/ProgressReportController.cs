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
    [Route("admin/progressReport")]
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
            int ClassSectionId = 0;
            
            var ProgressReport = _StudentProgressReportRepository.GetProgressReportByClassSectionId($@"EXEC spGetStudentProgressReportByClassSectionId '" + ClassSectionId + "','" + StartDate + "','" + EndDate + "'");

            ViewBag.Class = _StudentProgressReportRepository.GetAllClass();

            ViewBag.Section = _StudentProgressReportRepository.GetAllSection();

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
        [Route("viewProgressReport")]
        public async Task<IActionResult> ViewProgressReport(string StartDate, string EndDate, int Class_Id, int Section_Id)
        {
            string sDate = Convert.ToDateTime(StartDate).ToString("yyyyMMdd");
            string eDate = Convert.ToDateTime(EndDate).ToString("yyyyMMdd");
            

            //get class section id
            var ClassSection = await _StudentProgressReportRepository.GetClassSectionById(Class_Id, Section_Id);

            if (ClassSection != null)
            {
                var ProgressReport = _StudentProgressReportRepository.GetProgressReportByClassSectionId($@"EXEC spGetStudentProgressReportByClassSectionId '" + ClassSection.ClassSection_id + "','" + StartDate + "','" + EndDate + "'");

                ViewBag.Class = _StudentProgressReportRepository.GetAllClass();

                ViewBag.Section = _StudentProgressReportRepository.GetAllSection();

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
            else
            {
                TempData["Error"] = "Did't Find Class And Section";
                return RedirectToAction("progressReport", "progressReport", new { area = "admin" });

            }
            
        }
    }
}