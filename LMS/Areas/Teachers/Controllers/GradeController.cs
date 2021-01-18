using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    [Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/grade")]
    public class GradeController : Controller
    {

        private readonly ITPClassRepository _tPClassRepository;
        private readonly ILectureRepository _LectureRepository;
        private readonly ITeacherGradeRepository _TeacherGradeRepository;

        public GradeController(ITPClassRepository tPClassRepository, ILectureRepository LectureRepository, ITeacherGradeRepository TeacherGradeRepository)
        {
            _tPClassRepository = tPClassRepository;
            _LectureRepository = LectureRepository;
            _TeacherGradeRepository = TeacherGradeRepository;
        }

        //public IActionResult Index()
        //{
        //    return View();
        //}


        [Route("subjects")]
        public IActionResult Subjects(int ClassSectionId)
        {
            var TeacherClassSubjects = _tPClassRepository.GetTeacherClassSubjectLectures(HttpContext.Session.GetInt32("UserId") ?? 1, ClassSectionId);

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(TeacherClassSubjects);
        }

        [HttpGet]
        [Route("students/{ClassSubjectId}")]
        public IActionResult Students(int ClassSubjectId)
        {
            string StartDate = "01010101";
            string EndDate = "01010102";

            var Students = _TeacherGradeRepository.RunSql($@"EXEC spGetStudentGradeBySubjectId '"+ ClassSubjectId + "','" + StartDate + "','" + EndDate + "'");

            ViewBag.ClassSubjectId = ClassSubjectId;

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Students);
        }


        [HttpGet]
        [Route("studentsGrade/{ClassSubjectId}")]
        public IActionResult StudentsGrade(int ClassSubjectId, string StartDate, string EndDate)
        {

            string sDate = Convert.ToDateTime(StartDate).ToString("yyyyMMdd");
            string eDate = Convert.ToDateTime(EndDate).ToString("yyyyMMdd");

            var Students = _TeacherGradeRepository.RunSql($@"EXEC spGetStudentGradeBySubjectId '"+ ClassSubjectId + "','" + sDate + "','" + eDate + "'");

            ViewBag.ClassSubjectId = ClassSubjectId;
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

            return View("Students", Students);
        }

        [Route("studentsTestResults/{StudentId}")]
        public IActionResult StudentsTestResults(int StudentId, int ClassSubjectId, string StartDate, string EndDate)
        {

            
            string sDate = Convert.ToDateTime(StartDate).ToString("yyyyMMdd");
            string eDate = Convert.ToDateTime(EndDate).ToString("yyyyMMdd");


            var Test = _TeacherGradeRepository.GetStudentsAllTestResults($@"EXEC spGetStudentGradeByTestId '" + ClassSubjectId + "', '" + StudentId + "','" + sDate + "','" + eDate + "'");



            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Test);
        }
    }
}
