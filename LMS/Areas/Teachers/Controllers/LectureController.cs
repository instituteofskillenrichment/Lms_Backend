using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Configuration;
using MimeKit;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    [Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/lecture")]
    public class LectureController : Controller
    {
        private readonly ILectureRepository _LectureRepository;
        private readonly ITPClassRepository _tPClassReposiroty;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;

        public LectureController(ILectureRepository LectureRepository, 
                                 ITPClassRepository tPClassReposiroty,
                                 IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _LectureRepository = LectureRepository;
            _tPClassReposiroty = tPClassReposiroty;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [Route("")]
        [Route("lectures")]
        public async Task<IActionResult> Index()
        {
            var Lectures = await _LectureRepository.GetAllLecture(HttpContext.Session.GetInt32("UserId") ?? 0);

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Lectures);
        }

        [HttpGet]
        [Route("addLecture")]
        public IActionResult AddLecture()
        {
            List<SelectListItem> classList = new List<SelectListItem>();
            classList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
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
            sectionList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
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
            subjectList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
            ViewBag.SubjectList = subjectList;

            return View();
        }



        [HttpPost]
        [Route("addLecture")]
        public async Task<IActionResult> AddLecture(LectureViewModel objLecture)
        {
            if (ModelState.IsValid)
            {
                string uniqueFileName = Utility.ProcessUploadedFile(objLecture.Lecture_File, _hostingEnvironment, "Lectures");

                var classSectionObj = await _tPClassReposiroty.GetClassSectionById(objLecture.Class_Id, objLecture.Section_Id);

                if (classSectionObj != null)
                { 

                    var classSubjectObj = await _tPClassReposiroty.GetClassSubjectById(classSectionObj.ClassSection_id, objLecture.Subject_Id);

                    if (classSectionObj != null)
                    { 

                        Lecture newLecture = new Lecture
                        {
                            Lecture_Name = objLecture.Lecture_Name.ToUpper(),
                            Lecture_Detail = objLecture.Lecture_Detail,
                            Lecture_File = uniqueFileName,
                            LecturePost_Date = objLecture.LecturePost_Date.ToString("yyyyMMdd"), //DateTime.Now.ToString(),
                            Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 0,
                            ClassSubject_Id = classSubjectObj.ClassSubject_Id
                        };

                        int result = await _LectureRepository.AddLecture(newLecture);
                        if (result == 1)
                        {
                            TempData["Success"] = " Lecture Added Successfully";
                            //return RedirectToAction("Index", "lecture", new { area = "teachers" });
                            return RedirectToAction("subjects", "class", new { ClassSectionId= classSectionObj.ClassSection_id, area = "teachers" });
                        }
                        else
                        {
                            TempData["Error"] = "Adding Lecture Failed";
                            ///return RedirectToAction("Index", "lecture", new { area = "teachers" });
                            return RedirectToAction("subjects", "class", new { ClassSectionId = classSectionObj.ClassSection_id, area = "teachers" });
                        }
                    }
                    else
                    {
                        TempData["Error"] = "Class And Section Dont Have Seleceted Subject";
                        //return RedirectToAction("Index", "lecture", new { area = "teachers" });
                        return RedirectToAction("subjects", "class", new { ClassSectionId = classSectionObj.ClassSection_id, area = "teachers" });
                    }
                }
                else
                {
                    TempData["Error"] = "Class With Section Didn't Find";
                    //return RedirectToAction("Index", "lecture", new { area = "teachers" });
                    return RedirectToAction("subjects", "class", new { ClassSectionId = classSectionObj.ClassSection_id, area = "teachers" });
                }

            }

            return View();
        }

        [HttpGet]
        [Route("editLecture/{id}")]
        public async Task<IActionResult> EditLecture(int id)
        {
            var objLecture = await _LectureRepository.GetLectureById(id);

            EditLectureViewModel model = new EditLectureViewModel
            {
                //Id = objLecture.Lecture_Id,
                Id = objLecture.Id,
                Lecture_Name = objLecture.Lecture_Name,
                Lecture_Detail = objLecture.Lecture_Detail,
                //ExistingFilePath = objLecture.Lecture_File,
                ExistingFilePath = objLecture.ExistingFilePath,
                LecturePost_Date = objLecture.LecturePost_Date,
                Class_Id = objLecture.Class_Id,
                Section_Id = objLecture.Section_Id,
                Subject_Id = objLecture.Subject_Id

            };

            List<SelectListItem> classList = new List<SelectListItem>();
            classList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
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
            sectionList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
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
            subjectList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
            ViewBag.SubjectList = subjectList;

            return View(model);
        }

        [HttpPost]
        [Route("editLecture/{id}")]
        public async Task<IActionResult> EditLecture(EditLectureViewModel model)
        {
            if (ModelState.IsValid)
            {
                
                var classSectionObj = await _tPClassReposiroty.GetClassSectionById(model.Class_Id, model.Section_Id);

                if (classSectionObj != null)
                { 

                    var classSubjectObj = await _tPClassReposiroty.GetClassSubjectById(classSectionObj.ClassSection_id, model.Subject_Id);

                    if (classSubjectObj != null)
                    {
                        var objLecture = await _LectureRepository.GetLectureById(model.Id);

                        //objLecture.Lecture_Name = model.Lecture_Name;
                        //objLecture.Lecture_Detail = model.Lecture_Detail;
                        //objLecture.LecturePost_Date = model.LecturePost_Date;
                        //objLecture.Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 1;
                        //objLecture.ClassSubject_Id = classSubjectObj.ClassSubject_Id;

                        Lecture Lecture = new Lecture();
                        Lecture.Lecture_Id = model.Id;
                        Lecture.Lecture_Name = model.Lecture_Name.ToUpper();
                        Lecture.Lecture_Detail = model.Lecture_Detail;
                        Lecture.LecturePost_Date = model.LecturePost_Date.ToString("yyyyMMdd");
                        Lecture.Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 0;
                        Lecture.ClassSubject_Id = classSubjectObj.ClassSubject_Id;
                        


                        if (model.Lecture_File != null)
                        {
                            if (model.ExistingFilePath != null)
                            {
                                string filePath = Path.Combine(_hostingEnvironment.WebRootPath,
                                    "Lectures", model.ExistingFilePath);
                                System.IO.File.Delete(filePath);
                            }
                            
                            string uniqueFileName = Utility.ProcessUploadedFile(model.Lecture_File, _hostingEnvironment, "Lectures");

                            //objLecture.Lecture_File = uniqueFileName;
                            Lecture.Lecture_File = uniqueFileName;

                        }
                        else
                        {
                            Lecture.Lecture_File = objLecture.ExistingFilePath;
                        }

                        int result= await _LectureRepository.UpdateLecture(Lecture);
                        if (result == 1)
                        {
                            TempData["Success"] = "Lecture Updated Successfully";
                            return RedirectToAction("Index", "lecture", new { area = "teachers" });
                        }
                        else
                        {
                            TempData["Error"] = "Updating Lecture Failed ";
                            return RedirectToAction("Index", "lecture", new { area = "teachers" });
                        }
                    }
                    else
                    {
                        TempData["Error"] = "Class And Section Dont Have Seleceted Subject";
                        return RedirectToAction("Index", "lecture", new { area = "teachers" });
                    }
                }
                else
                {
                    TempData["Error"] = "Class With Section Didn't Find";
                    return RedirectToAction("Index", "lecture", new { area = "teachers" });
                }

            }

            return View();
        }

        [HttpPost]
        [Route("deleteLecture")]
        public async Task<IActionResult> DeleteLecture(int Lecture_Id)
        {
            if(ModelState.IsValid)
            {
                int result = await _LectureRepository.DeleteLecture(Lecture_Id);
                if (result == 1)
                {
                    TempData["Success"] = "Delete Lecture Successfully";
                    return RedirectToAction("Index", "lecture", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Deleting Lecture Failed";
                    return RedirectToAction("Index", "lecture", new { area = "teachers" });
                }

                
            }

            return View();

        }

        [HttpGet]
        [Route("downloadLecture")]
        public async Task<IActionResult> DownloadLecture(int lectureId)
        {
            var lectureFile = await _LectureRepository.GetLectureById(lectureId);

            //string fileName = lectureFile.Lecture_File.Split('_')[1];
            string fileName = lectureFile.ExistingFilePath.Split('_')[1];

            //lectureFile.Lecture_File = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.Lecture_File;
            lectureFile.ExistingFilePath = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.ExistingFilePath;

           // return PhysicalFile(lectureFile.Lecture_File, MimeTypes.GetMimeType(lectureFile.Lecture_File), fileName);
            return PhysicalFile(lectureFile.ExistingFilePath, MimeTypes.GetMimeType(lectureFile.ExistingFilePath), fileName);
        }
    }
}