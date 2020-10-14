using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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
        public async Task<IActionResult> Index(int ClassSubjectId)
        {
            var Lectures = await _LectureRepository.GetLectureBySubject(ClassSubjectId);

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
            List<Class> classList = _LectureRepository.GetAllClass().ToList();

            ViewBag.ClassList = classList;

            List<Section> sectionList = _LectureRepository.GetAllSection().ToList();

            ViewBag.SectionList = sectionList;

            List<Subject> subjectList = _LectureRepository.GetAllSubject().ToList();

            ViewBag.SubjectList = subjectList;

            return View();
        }



        [HttpPost]
        [Route("addLecture")]
        public async Task<IActionResult> AddLecture(LectureViewModel objLecture)
        {
            if (ModelState.IsValid)
            {
                string uniqueFileName = Utility.ProcessUploadedFile(objLecture, _hostingEnvironment);

                var classSectionObj = await _tPClassReposiroty.GetClassSectionById(objLecture.Class_Id, objLecture.Section_Id);

                var classSubjectObj = await _tPClassReposiroty.GetClassSubjectById(classSectionObj.ClassSection_id);

                Lecture newLecture = new Lecture
                {
                    Lecture_Name = objLecture.Lecture_Name,
                    Lecture_Detail = objLecture.Lecture_Detail,
                    Lecture_File = uniqueFileName,
                    LecturePost_Date = DateTime.Now.ToString(),
                    Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 1,
                    ClassSubject_Id = classSubjectObj.ClassSubject_Id
                };

                int result = await _LectureRepository.AddLecture(newLecture);
                if (result == 1)
                {
                    TempData["Success"] = " Lecture Added Successfully";
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Adding Lecture Failed";
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
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
                Id = objLecture.Lecture_Id,
                Lecture_Name = objLecture.Lecture_Name,
                Lecture_Detail = objLecture.Lecture_Detail,
                ExistingFilePath = objLecture.Lecture_File,
                LecturePost_Date = Convert.ToDateTime(objLecture.LecturePost_Date)
            };

            List<Class> classList = _LectureRepository.GetAllClass().ToList();

            ViewBag.ClassList = classList;

            List<Section> sectionList = _LectureRepository.GetAllSection().ToList();

            ViewBag.SectionList = sectionList;

            List<Subject> subjectList = _LectureRepository.GetAllSubject().ToList();

            ViewBag.SubjectList = subjectList;

            return View(model);
        }

        [HttpPost]
        [Route("editLecture/{id}")]
        public async Task<IActionResult> EditLecture(EditLectureViewModel model)
        {
            if (ModelState.IsValid)
            {
                var objLecture = await _LectureRepository.GetLectureById(model.Id);

                var classSectionObj = await _tPClassReposiroty.GetClassSectionById(model.Class_Id, model.Section_Id);

                var classSubjectObj = await _tPClassReposiroty.GetClassSubjectById(classSectionObj.ClassSection_id);

                objLecture.Lecture_Name = model.Lecture_Name;
                objLecture.Lecture_Detail = model.Lecture_Detail;
                objLecture.LecturePost_Date = DateTime.Now.ToString();
                objLecture.Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 1;
                objLecture.ClassSubject_Id = classSubjectObj.ClassSubject_Id;

                if (model.Lecture_File != null)
                {
                    if (model.ExistingFilePath != null)
                    {
                        string filePath = Path.Combine(_hostingEnvironment.WebRootPath,
                            "Lectures", model.ExistingFilePath);
                        System.IO.File.Delete(filePath);
                    }
                    
                    string uniqueFileName = Utility.ProcessUploadedFile(model, _hostingEnvironment);
                    
                    objLecture.Lecture_File = uniqueFileName;

                }

                int result= await _LectureRepository.UpdateLecture(objLecture);
                if (result == 1)
                {
                    TempData["Success"] = "Lecture Updated Successfully";
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updating Lecture Failed ";
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
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
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Lecture Failed";
                    return RedirectToAction("Index", "lecture", new { area = "admin" });
                }

                
            }

            return View();

        }

        [HttpGet]
        [Route("downloadLecture")]
        public async Task<IActionResult> DownloadLecture(int lectureId)
        {
            var lectureFile = await _LectureRepository.GetLectureById(lectureId);

            string fileName = lectureFile.Lecture_File.Split('_')[1];

            lectureFile.Lecture_File = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.Lecture_File;

            return PhysicalFile(lectureFile.Lecture_File, MimeTypes.GetMimeType(lectureFile.Lecture_File), fileName);
        }
    }
}