using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MimeKit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    [Area("teachers")]
    [Route("teachers/lecture")]
    public class LectureController : Controller
    {
        private readonly ILectureRepository _LectureRepository;
        private readonly IClassRepository _ClassRepository;
        private readonly ISectionRepository _SectionRepository;
        private readonly ISubjectRepository _SubjectRepository;
        private readonly IStudentClassRepository _StudentClassRepository;
        private readonly ITeacherSubjectRepository _TeacherSubjectRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;

        public LectureController(ILectureRepository LectureRepository, IClassRepository ClassRepository,
            IStudentClassRepository StudentClassRepository, ISectionRepository SectionRepository, 
            ISubjectRepository SubjectRepository, ITeacherSubjectRepository TeacherSubjectRepository, 
            IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _LectureRepository = LectureRepository;
            _ClassRepository = ClassRepository;
            _SectionRepository = SectionRepository;
            _SubjectRepository = SubjectRepository;
            _StudentClassRepository = StudentClassRepository;
            _TeacherSubjectRepository = TeacherSubjectRepository;
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
            List<Class> classList = _ClassRepository.GetAllClass().ToList();

            ViewBag.ClassList = classList;

            List<Section> sectionList = _SectionRepository.GetAllSection().ToList();

            ViewBag.SectionList = sectionList;

            List<Subject> subjectList = _SubjectRepository.GetAllSubject().ToList();

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

                var classSectionObj = await _StudentClassRepository.GetClassSectionById(objLecture.Class_Id, objLecture.Section_Id);

                var classSubjectObj = await _TeacherSubjectRepository.GetClassSubjectById(classSectionObj.ClassSection_id);

                Lecture newLecture = new Lecture
                {
                    Lecture_Name = objLecture.Lecture_Name,
                    Lecture_Detail = objLecture.Lecture_Detail,
                    Lecture_File = uniqueFileName,
                    LecturePost_Date = DateTime.Now.ToString(),
                    Teacher_Id = 2,
                    ClassSubject_Id = classSubjectObj.ClassSubject_Id
                };

                await _LectureRepository.AddLecture(newLecture);

                return RedirectToAction("Index", "subject", new { area = "admin" });

            }

            return View();
        }

        [HttpPost]
        [Route("deleteLecture")]
        public async Task<IActionResult> DeleteLecture(int Lecture_Id)
        {
            await _LectureRepository.DeleteLecture(Lecture_Id);

            return RedirectToAction("Index", "lecture", new { area = "teacher" });

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