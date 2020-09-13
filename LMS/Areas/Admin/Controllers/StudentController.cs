using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/student")]
    public class StudentController : Controller
    {
        private readonly IStudentRepository _StudentRepository;

        public StudentController(IStudentRepository StudentRepository)
        {
            _StudentRepository = StudentRepository;
        }
       
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Student = _StudentRepository.GetAllStudent();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Student);
        }

        [HttpPost]
        [Route("addStudent")]
        public async Task<IActionResult> AddStudent(Student objStudent)
        {
            if (ModelState.IsValid)
            {
                Student newStudent = new Student
                {
                    Student_Name = objStudent.Student_Name
                };

                int result = await _StudentRepository.AddStudent(newStudent);

                if (result == 1)
                {
                    TempData["Success"] = "Student successfully added.";
                    return RedirectToAction("Index", "Student", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Failed to add student. Please try again!";
                    return RedirectToAction("Index", "Student", new { area = "admin" });
                }
            }

            return View();
        }

        [HttpPost]
        [Route("deleteStudent")]
        public async Task<IActionResult> DeleteStudent(int Student_Id)
        {
            int result = await _StudentRepository.DeleteStudent(Student_Id);

            if (result == 1)
            {
                TempData["Success"] = "Student successfully deleted.";
                return RedirectToAction("Index", "Student", new { area = "admin" });
            }
            else
            {
                TempData["Error"] = "Failed to delete student. Please try again!";
                return RedirectToAction("Index", "Student", new { area = "admin" });
            }
        }

        [HttpGet]
        [Route("editStudent/{id}")]
        public async Task<IActionResult> EditStudent(int id)
        {
            var objStudent = await _StudentRepository.GetStudentById(id);

            return new JsonResult(objStudent);

        }

        [HttpPost]
        [Route("editStudent")]
        public async Task<IActionResult> EditStudent(Student StudentModel)
        {
            if (ModelState.IsValid)
            {
                Student objStudent = await _StudentRepository.GetStudentById(StudentModel.Student_Id);

                objStudent.Student_Name = StudentModel.Student_Name;

                int result = await _StudentRepository.UpdateStudent(objStudent);

                if (result == 1)
                {
                    TempData["Success"] = "Student successfully updated.";
                    return RedirectToAction("Index", "Student", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Failed to update student. Please try again!";
                    return RedirectToAction("Index", "Student", new { area = "admin" });
                }
            }

            return View();
        }
    }
}