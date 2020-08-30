using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/teacher")]
    public class TeacherController : Controller
    {
        private readonly ITeacherRepository _TeacherRepository;

        public TeacherController(ITeacherRepository TeacherRepository)
        {
            _TeacherRepository = TeacherRepository;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Teacher = _TeacherRepository.GetAllTeacher();

            return View(Teacher);
        }

        [HttpPost]
        [Route("addTeacher")]
        public async Task<IActionResult> AddTeacher(Teacher objTeacher)
        {
            if (ModelState.IsValid)
            {
                Teacher newTeacher = new Teacher
                {
                    Teacher_Name = objTeacher.Teacher_Name
                };

                await _TeacherRepository.AddTeacher(newTeacher);

                return RedirectToAction("Index", "Teacher", new { area = "admin" });

            }

            return View();
        }

        [HttpPost]
        [Route("deleteTeacher")]
        public async Task<IActionResult> DeleteTeacher(int Teacher_Id)
        {
            await _TeacherRepository.DeleteTeacher(Teacher_Id);

            return RedirectToAction("Index", "Teacher", new { area = "admin" });

        }

        [HttpGet]
        [Route("editTeacher/{id}")]
        public async Task<IActionResult> EditTeacher(int id)
        {
            var objTeacher = await _TeacherRepository.GetTeacherById(id);

            return new JsonResult(objTeacher);

        }

        [HttpPost]
        [Route("editTeacher")]
        public async Task<IActionResult> EditTeacher(Teacher TeacherModel)
        {
            if (ModelState.IsValid)
            {
                Teacher objTeacher = await _TeacherRepository.GetTeacherById(TeacherModel.Teacher_Id);

                objTeacher.Teacher_Name = TeacherModel.Teacher_Name;

                await _TeacherRepository.UpdateTeacher(objTeacher);

                return RedirectToAction("Index", "Teacher", new { area = "admin" });

            }

            return View();
        }
    }
}