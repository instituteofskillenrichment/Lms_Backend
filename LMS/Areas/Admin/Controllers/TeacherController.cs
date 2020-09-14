using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Hosting.Internal;
using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/teacher")]
    public class TeacherController : Controller
    {
        private readonly ITeacherRepository _TeacherRepository;
        private readonly HostingEnvironment _hostingEnvironment;


        public TeacherController(ITeacherRepository TeacherRepository, HostingEnvironment hostingEnvironment)
        {
            _TeacherRepository = TeacherRepository;
            _hostingEnvironment = hostingEnvironment;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Teacher = _TeacherRepository.GetAllTeacher();
            

            return View(Teacher);
        }


        [HttpGet]
        [Route("addTeacher")]
        public IActionResult AddTeacher()
        {
            return View();
        }



        [HttpPost]
        [Route("addTeacher")]
        public async Task<IActionResult> AddTeacher(Teacher objTeacher)
        {
            if (ModelState.IsValid)
            {
                Teacher newTeacher = new Teacher
                {
                    Teacher_Name = objTeacher.Teacher_Name,
                    Teacher_City = objTeacher.Teacher_City,
                    Teacher_Cnic = objTeacher.Teacher_Cnic,
                    Teacher_Country = objTeacher.Teacher_Country,
                    Teacher_CurrentAddress = objTeacher.Teacher_CurrentAddress,
                    Teacher_DOB = objTeacher.Teacher_DOB,
                    Teacher_Department = objTeacher.Teacher_Department,
                    Teacher_Designation = objTeacher.Teacher_Designation,
                    Teacher_Email = objTeacher.Teacher_Email,
                    Teacher_FatherName = objTeacher.Teacher_FatherName,
                    Teacher_Gender = objTeacher.Teacher_Gender,
                    Teacher_HomePhone = objTeacher.Teacher_HomePhone,
                    Teacher_LastDegree = objTeacher.Teacher_LastDegree,
                    Teacher_MobNumber = objTeacher.Teacher_MobNumber,
                    Teacher_PermenentAddress = objTeacher.Teacher_PermenentAddress,
                    Teacher_Photo = objTeacher.Teacher_Photo


                };

                int Id =  await _TeacherRepository.AddTeacher(newTeacher);

                UploadImage(Id);

                await _TeacherRepository.SaveChanges();

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

            return View(objTeacher);

        }

        [HttpPost]
        [Route("editTeacher/{id}")]
        public async Task<IActionResult> EditTeacher(Teacher TeacherModel)
        {
            if (ModelState.IsValid)
            {
                Teacher objTeacher = await _TeacherRepository.GetTeacherById(TeacherModel.Teacher_Id);

                //objTeacher.Teacher_Name = TeacherModel.Teacher_Name;
                objTeacher.Teacher_Name = TeacherModel.Teacher_Name;
                objTeacher.Teacher_City = TeacherModel.Teacher_City;
                objTeacher.Teacher_Cnic = TeacherModel.Teacher_Cnic;
                objTeacher.Teacher_Country = TeacherModel.Teacher_Country;
                objTeacher.Teacher_CurrentAddress = TeacherModel.Teacher_CurrentAddress;
                objTeacher.Teacher_DOB = TeacherModel.Teacher_DOB;
                objTeacher.Teacher_Department = TeacherModel.Teacher_Department;
                objTeacher.Teacher_Designation = TeacherModel.Teacher_Designation;
                objTeacher.Teacher_Email = TeacherModel.Teacher_Email;
                objTeacher.Teacher_FatherName = TeacherModel.Teacher_FatherName;
                objTeacher.Teacher_Gender = TeacherModel.Teacher_Gender;
                objTeacher.Teacher_HomePhone = TeacherModel.Teacher_HomePhone;
                objTeacher.Teacher_LastDegree = TeacherModel.Teacher_LastDegree;
                objTeacher.Teacher_MobNumber = TeacherModel.Teacher_MobNumber;
                objTeacher.Teacher_PermenentAddress = TeacherModel.Teacher_PermenentAddress;
                //objTeacher.Teacher_Photo = TeacherModel.Teacher_Photo;

                await _TeacherRepository.UpdateTeacher(objTeacher);

                UploadImage(objTeacher.Teacher_Id);

                await _TeacherRepository.SaveChanges();

                return RedirectToAction("Index", "Teacher", new { area = "admin" });

            }

            return View();
        }



        public void UploadImage(int id)
        {
            //login to save image path in db
            //get bike id we have saved in db

            //var BikeID = BikeVM.Bike.Id;

            var teacherId = id;

            //gte eeeroot folder path on save image on server

            string wwwRootPath = _hostingEnvironment.WebRootPath;

            //get the upload file
            var files = HttpContext.Request.Form.Files;

            //get the referenc of blog image we have saved in db
            var SaveTeacher = _TeacherRepository.FindTeacherById(teacherId);
            
            

            //upload hte image on server and save path on db

            if (files.Count != 0)
            {
                var imagePath = @"\Dashboard\assets\img\Teacher-Img\";
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
                SaveTeacher.Teacher_Photo = RelativeImagePath;
                //_TeacherRepository.SaveChanges();

            }
        }

    }
}