using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Hosting.Internal;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/student")]
    public class StudentController : Controller
    {
        private readonly IStudentRepository _StudentRepository;
        private readonly IStudentClassRepository _StudentClassRepository;
        private readonly HostingEnvironment _hostingEnvironment;

        public StudentController(IStudentRepository StudentRepository, IStudentClassRepository StudentClassRepository , HostingEnvironment hostingEnvironment)
        {
            _StudentRepository = StudentRepository;
            _StudentClassRepository = StudentClassRepository;
            _hostingEnvironment = hostingEnvironment;
        }
       
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {

            var studentClassVM = new StudentClassViewModel();
            studentClassVM.Students = _StudentRepository.GetAllStudent().ToList();
            
            studentClassVM.Classes = new List<SelectListItem>();
            var objClass = _StudentClassRepository.GetAllClasses().ToList();
            foreach (var lstclass in objClass)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                studentClassVM.Classes.Add(selectListItem);
            }

            studentClassVM.Sections = new List<SelectListItem>();
            var objSection = _StudentClassRepository.GetAllSections().ToList();
            foreach (var lstSection in objSection)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                studentClassVM.Sections.Add(selectListItem);
            }


            return View(studentClassVM);
        }



        [HttpGet]
        [Route("addStudent")]
        public IActionResult AddStudent()
        {
            return View();
        }



        [HttpPost]
        [Route("addStudent")]
        public async Task<IActionResult> AddStudent(Student objStudent)
        {
            if (ModelState.IsValid)
            {
                Student newStudent = new Student
                {
                    Student_Name = objStudent.Student_Name,
                    Student_City= objStudent.Student_City,
                    Student_Cnic = objStudent.Student_Cnic,
                    Student_Country = objStudent.Student_Country,
                    Student_CurrentAddress = objStudent.Student_CurrentAddress,
                    Student_DOB = objStudent.Student_DOB,
                    Student_Email = objStudent.Student_Email,
                    Student_FatherName = objStudent.Student_FatherName,
                    Student_Gender = objStudent.Student_Gender,
                    Student_HomePhone = objStudent.Student_HomePhone,
                    Student_MobNumber = objStudent.Student_MobNumber,
                    Student_PermenentAddress = objStudent.Student_PermenentAddress
                };

                int Id = await _StudentRepository.AddStudent(newStudent);

                UploadImage(Id);

                await _StudentRepository.SaveChanges();

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

            return View(objStudent);

        }



        [HttpPost]
        [Route("editStudent/{id}")]
        public async Task<IActionResult> EditStudent(Student StudentModel)
        {
            if (ModelState.IsValid)
            {
                Student objStudent = await _StudentRepository.GetStudentById(StudentModel.Student_Id);

                objStudent.Student_Name = StudentModel.Student_Name;
                objStudent.Student_City = StudentModel.Student_City;
                objStudent.Student_Cnic = StudentModel.Student_Cnic;
                objStudent.Student_Country = StudentModel.Student_Country;
                objStudent.Student_CurrentAddress = StudentModel.Student_CurrentAddress;
                objStudent.Student_DOB = StudentModel.Student_DOB;
              //  objStudent.Student_Department = TeacherModel.Teacher_Department;
             //   objStudent.Student_Designation = TeacherModel.Teacher_Designation;
                objStudent.Student_Email = StudentModel.Student_Email;
                objStudent.Student_FatherName = StudentModel.Student_FatherName;
                objStudent.Student_Gender = StudentModel.Student_Gender;
                objStudent.Student_HomePhone = StudentModel.Student_HomePhone;
            //    objStudent.Student_LastDegree = TeacherModel.Teacher_LastDegree;
                objStudent.Student_MobNumber = StudentModel.Student_MobNumber;
                objStudent.Student_PermenentAddress = StudentModel.Student_PermenentAddress;

                await _StudentRepository.UpdateStudent(objStudent);

                UploadImage(objStudent.Student_Id);

                await _StudentRepository.SaveChanges();

                return RedirectToAction("Index", "Student", new { area = "admin" });

            }

            return View();
        }



        [HttpGet]
        [Route("addStudentClass/{id}")]
        public async Task<IActionResult> AddStudentClass(int id)
        {
            
            var objStudent = await _StudentRepository.GetStudentById(id);
            

            var studentClassVM = new StudentClassViewModel();
            studentClassVM.Students = _StudentRepository.GetAllStudent().ToList();
            

            studentClassVM.Classes = new List<SelectListItem>();
            var objClass = _StudentClassRepository.GetAllClasses().ToList();
            foreach (var lstclass in objClass)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                studentClassVM.Classes.Add(selectListItem);
            }

            studentClassVM.Sections = new List<SelectListItem>();
            var objSection = _StudentClassRepository.GetAllSections().ToList();
            foreach (var lstSection in objSection)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                studentClassVM.Sections.Add(selectListItem);
            }

            return new JsonResult(objStudent);

        }



        [HttpPost]
        [Route("addStudentClass")]
        public async Task<IActionResult> AddStudentClass(StudentClassViewModel studentClassModel)
        {
            if (ModelState.IsValid)
            {
                var objClassSection = await _StudentClassRepository.GetClassSectionById(studentClassModel.Class_Id, studentClassModel.Section_Id);

                StudentClass studentClass = new StudentClass();
                studentClass.Student_Id = studentClassModel.Student_Id;
                studentClass.ClassSection_id = objClassSection.ClassSection_id;
                


                await _StudentClassRepository.AddStudentClass(studentClass);

                return RedirectToAction("Index", "student", new { area = "admin" });

            }

            return View();
        }
        


        [HttpGet]
        [Route("editStudentClass/{id}")]
        public async Task<IActionResult> EditStudentClass(int id)
        {

           
            var objStudentClass = await _StudentClassRepository.GetSudentClassById(id);

            return new JsonResult(objStudentClass);
        }



        [HttpPost]
        [Route("editStudentClass")]
        public async Task<IActionResult> EditStudentClass(StudentClassViewModel studentClassModel)
        {
            if (ModelState.IsValid)
            {
                
                //get class section id
                var ClassSection = await _StudentClassRepository.GetClassSectionById(studentClassModel.Class_Id, studentClassModel.Section_Id);

                //assign new values to class subject
                StudentClass objStudentClass = new StudentClass();

                objStudentClass.StudentClass_Id = studentClassModel.StudentClass_Id;
                objStudentClass.ClassSection_id = ClassSection.ClassSection_id;
                objStudentClass.Student_Id = studentClassModel.Student_Id;


                await _StudentClassRepository.UpdateStudentClass(objStudentClass);

                return RedirectToAction("StudentClassDetail", "student", new { area = "admin" });

            }

            return View();
        }



        [HttpPost]
        [Route("deleteStudentClass")]
        public async Task<IActionResult> deleteStudentClass(int StudentClass_Id)
        {
            await _StudentClassRepository.DeleteStudentClass(StudentClass_Id);

            return RedirectToAction("StudentClassDetail", "student", new { area = "admin" });

        }



        [HttpGet]
        [Route("studentClassDetail")]
        public IActionResult StudentClassDetail()
        {
            var objStudentClassDetail = _StudentClassRepository.GetAllStudentsClass();


            ViewBag.Class = _StudentClassRepository.GetAllClasses();

            ViewBag.Section = _StudentClassRepository.GetAllSections();

            return View(objStudentClassDetail);
        }



        [HttpGet]
        [Route("studentSubjectDetail")]
        public IActionResult StudentSubjectDetail(int id)
        {
            var StudentSubject = _StudentClassRepository.GetStudentSubjectByStudentId(id);
            
            return View(StudentSubject);
        }



        public void UploadImage(int id)
        {
            //login to save image path in db
            //get bike id we have saved in db

            //var BikeID = BikeVM.Bike.Id;

            var studentId = id;

            //gte eeeroot folder path on save image on server

            string wwwRootPath = _hostingEnvironment.WebRootPath;

            //get the upload file
            var files = HttpContext.Request.Form.Files;

            //get the referenc of blog image we have saved in db
            var SaveStudent = _StudentRepository.FindStudentById(studentId);



            //upload hte image on server and save path on db

            if (files.Count != 0)
            {
                var imagePath = @"\Dashboard\assets\img\Student-Img\";
                // var Extension = Path.GetExtension(files[0].FileName);
                var FileName = Path.GetFileName(files[0].FileName);
                var RelativeImagePath = imagePath + FileName;
                //var AbsoluteImagePath = Path.Combine(wwwRootPath, RelativeImagePath);
                var AbsoluteImagePath = wwwRootPath + RelativeImagePath;

                //upload file on server
                using (var fileStream = new FileStream(AbsoluteImagePath, FileMode.Create))
                {
                    files[0].CopyTo(fileStream);
                }

                //save imagepath to db
                SaveStudent.Student_Photo = RelativeImagePath;
                //_TeacherRepository.SaveChanges();

            }
        }



    }
}