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
    //[Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/attendance")]
    public class AttendanceController : Controller
    {
        private readonly ITPAttendanceRepository _tPAttendanceRepository;
        public AttendanceController(ITPAttendanceRepository tPAttendanceRepository)
        {
            _tPAttendanceRepository = tPAttendanceRepository;
        }

        [Route("")]
        [Route("session")]
        public IActionResult Session()
        {
            var sessionClassVM = new AttendanceViewModel();
            sessionClassVM.Sessions = _tPAttendanceRepository.GetAllSessionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();

            sessionClassVM.Classes = new List<SelectListItem>();
            var objClassSecSub = _tPAttendanceRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                sessionClassVM.Classes.Add(selectListItem);
            }


            sessionClassVM.Sections = new List<SelectListItem>();
           // var objSection = _tPAttendanceRepository.GetAllClassSectionSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                sessionClassVM.Sections.Add(selectListItem);
            }


            sessionClassVM.Subjects = new List<SelectListItem>();
            var objSubject = _tPAttendanceRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                sessionClassVM.Subjects.Add(selectListItem);
            }


            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(sessionClassVM);
        }


        [HttpPost]
        [Route("addSession")]
        public async Task<IActionResult> AddSession(AttendanceViewModel objVM)
        {
            if (ModelState.IsValid)
            {
                Session newSession = new Session
                {
                    Session_Name = objVM.Session_Name,
                    Date = objVM.Session_Date.ToString("yyyyMMdd"),
                    Start_Time = objVM.Session_Start_Time.ToString("HHmmss"),
                    End_Time = objVM.Session_End_Time.ToString("HHmmss"),
                    Section_Id = objVM.Section_Id,
                    Class_Id = objVM.Class_Id,
                    Subject_Id = objVM.Subject_Id,
                    Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 1
                };

                int result = await _tPAttendanceRepository.AddSession(newSession);
                if (result == 1)
                {
                    TempData["Success"] = " Session Added Successfully";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Adding Session Failed";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }



            }

            return View();
        }




        [HttpPost]
        [Route("deleteSession")]
        public async Task<IActionResult> DeleteSession(int Session_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _tPAttendanceRepository.DeleteSession(Session_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Delete Session Successfully";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Deleting Session Failed";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }
            }

            return View();

        }




        [HttpGet]
        [Route("editSession/{id}")]
        public async Task<IActionResult> EditSession(int id)
        {
            var objSession = await _tPAttendanceRepository.GetSessionById(id);

            return new JsonResult(objSession);

        }



        [HttpPost]
        [Route("editSession")]
        public async Task<IActionResult> EditSession(AttendanceViewModel sessionModel)
        {
            if (ModelState.IsValid)
            {
                Session objSession = await _tPAttendanceRepository.GetSessionById(sessionModel.Session_Id);

                objSession.Session_Name = sessionModel.Session_Name;
                objSession.Date = sessionModel.Session_Date.ToString();
                objSession.Start_Time = sessionModel.Session_Start_Time.ToString();
                objSession.End_Time = sessionModel.Session_End_Time.ToString();
                objSession.Class_Id = sessionModel.Class_Id;
                objSession.Section_Id = sessionModel.Section_Id;
                objSession.Subject_Id = sessionModel.Subject_Id;

                
                int result = await _tPAttendanceRepository.UpdateSession(objSession);

                if (result == 1)
                {
                    TempData["Success"] = "Session Updated Successfully";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Session Class Failed ";
                    return RedirectToAction("session", "attendance", new { area = "teachers" });
                }

            }

            return View();
        }


        [Route("")]
        [Route("markAttendance")]
        public IActionResult MarkAttendance(int Session_Id)
        {
            //var TeacherClassSubjects = _tPClassRepository.GetTeacherClassSubjectLectures(HttpContext.Session.GetInt32("UserId") ?? 1, ClassSectionId);
            List<SelectListItem> classList = new List<SelectListItem>();
            var objClassSecSub = _tPAttendanceRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                classList.Add(selectListItem);
            }
            ViewBag.ClassList = classList;


            List<SelectListItem> sectionList = new List<SelectListItem>();
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                sectionList.Add(selectListItem);
            }
            ViewBag.SectionList = sectionList;


            List<SelectListItem> subjectList = new List<SelectListItem>();
            var objSubject = _tPAttendanceRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 1).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
            ViewBag.subjectList = subjectList;

            var objStudentClassDetail = _tPAttendanceRepository.GetAllStudentsClass();

            

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(objStudentClassDetail);
        }
    }
}