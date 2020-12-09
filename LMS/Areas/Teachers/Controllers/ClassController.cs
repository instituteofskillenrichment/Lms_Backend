using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    //[Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/class")]
    public class ClassController : Controller
    {
       
        private readonly ITPClassRepository _tPClassRepository;
        private readonly ILectureRepository _LectureRepository;

        public ClassController(ITPClassRepository tPClassRepository, ILectureRepository LectureRepository)
        {
            _tPClassRepository = tPClassRepository;
            
            _LectureRepository = LectureRepository;
        }

        //264f72f4-c371-49d6-8d75-bc56ec189672
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {


            var TeacherClasses = _tPClassRepository.GetTeacherClassSubjectstDistinctByTeacherId(HttpContext.Session.GetInt32("UserId")??1);
            
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