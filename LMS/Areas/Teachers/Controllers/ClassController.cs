using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    [Area("teachers")]
    [Route("teachers/class")]
    public class ClassController : Controller
    {
        private readonly IClassRepository _ClassRepository;
        private readonly ITeacherSubjectRepository _TeacherSubjectRepository;
        private readonly ILectureRepository _LectureRepository;

        public ClassController(ITeacherSubjectRepository TeacherSubjectRepository, IClassRepository ClassRepository, ILectureRepository LectureRepository)
        {
            _TeacherSubjectRepository = TeacherSubjectRepository;
            _ClassRepository = ClassRepository;
            _LectureRepository = LectureRepository;
        }

        //264f72f4-c371-49d6-8d75-bc56ec189672
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var TeacherClasses = _TeacherSubjectRepository.GetTeacherClassSubjectstByTeacherId(2);

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(TeacherClasses);
        }


        [Route("")]
        [Route("subjects")]
        public IActionResult Subjects(int ClassSubjectId)
        {
            var TeacherClassSubjects = _TeacherSubjectRepository.GetTeacherClassSubjectLectures(2, ClassSubjectId);


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

        [Route("")]
        [Route("lectures")]
        public async Task<IActionResult> Lectures(int ClassSubjectId)
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
    }
}