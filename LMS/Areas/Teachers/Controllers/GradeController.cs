using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
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

        public IActionResult Index()
        {
            return View();
        }

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

        [Route("students")]
        public IActionResult Students(int ClassSubjectId)
        {
            var Students =  _TeacherGradeRepository.GetAllStudentsBySubjectId(ClassSubjectId);

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

        [Route("studentsTestResults")]
        public IActionResult StudentsTestResults(int StudentId)
        {
            var Students = _TeacherGradeRepository.GetStudentsAllTestResults(StudentId);

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
    }
}
