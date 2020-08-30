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

                await _StudentRepository.AddStudent(newStudent);

                return RedirectToAction("Index", "Student", new { area = "admin" });

            }

            return View();
        }

        [HttpPost]
        [Route("deleteStudent")]
        public async Task<IActionResult> DeleteStudent(int Student_Id)
        {
            await _StudentRepository.DeleteStudent(Student_Id);

            return RedirectToAction("Index", "Student", new { area = "admin" });

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

                await _StudentRepository.UpdateStudent(objStudent);

                return RedirectToAction("Index", "Student", new { area = "admin" });

            }

            return View();
        }
    }
}