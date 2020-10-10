using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting.Internal;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/teacher")]
    public class TeacherController : Controller
    {
        private readonly ITeacherRepository _TeacherRepository;
        private readonly ITeacherSubjectRepository _TeacherSubjectRepository;
        private readonly IUserRepository _UserRepository;
        private readonly HostingEnvironment _hostingEnvironment;


        public TeacherController(ITeacherRepository TeacherRepository, ITeacherSubjectRepository TeacherSubjectRepository,
            IUserRepository UserRepository, HostingEnvironment hostingEnvironment)
        {
            _TeacherRepository = TeacherRepository;
            _TeacherSubjectRepository = TeacherSubjectRepository;
            _UserRepository = UserRepository;
            _hostingEnvironment = hostingEnvironment;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Teacher = _TeacherRepository.GetAllTeacher();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }


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
                IdentityUser User = new IdentityUser
                {
                    UserName = objTeacher.Teacher_Email,
                    Email = objTeacher.Teacher_Email,
                    //PasswordHash = objTeacher.Teacher_Password
                };

                int userSucceed = await _UserRepository.CreateUser(User, objTeacher.Teacher_Password);

                if (userSucceed == 1)
                {
                    var response = await _UserRepository.AssignToRole(User, "Teacher");

                    if (response != 1)
                    {
                        TempData["Error"] = "Error In Assigning Role. Please try again!";
                        return RedirectToAction("Index", "Teacher", new { area = "admin" });
                    }


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
                        Teacher_Photo = objTeacher.Teacher_Photo,
                        Teacher_Ref_Id = User.Id
                    };


                    int Id = await _TeacherRepository.AddTeacher(newTeacher);

                    UploadImage(Id);

                    int result = await _TeacherRepository.SaveChanges();

                    if (result == 1)
                    {
                        TempData["Success"] = "Teachet Added Successfully";
                        return RedirectToAction("Index", "Teacher", new { area = "admin" });
                    }
                    else
                    {
                        TempData["Error"] = "Failed to add teacher. Please try again!";
                        return RedirectToAction("Index", "Teacher", new { area = "admin" });
                    }

                }
                else
                {
                    TempData["Error"] = "Error In Creating Teacher. Please try again!";
                    return RedirectToAction("Index", "Teacher", new { area = "admin" });
                }

            }

            return View();
        }

        [HttpPost]
        [Route("deleteTeacher")]
        public async Task<IActionResult> DeleteTeacher(int Teacher_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _TeacherRepository.DeleteTeacher(Teacher_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Teacher Deleted Successfully";
                    return RedirectToAction("Index", "Teacher", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Failed To Delete Teacher";
                    return RedirectToAction("Index", "Teacher", new { area = "admin" });
                }
            }

            return View();    
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


                int Id = await _TeacherRepository.UpdateTeacher(objTeacher);
                
                UploadImage(objTeacher.Teacher_Id);

                int result =  await _TeacherRepository.SaveChanges();

                if (result == 1)
                {
                    TempData["Success"] = "Teacher Updated Successfully";
                    return RedirectToAction("Index", "Teacher", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Failed To Update Teacher";
                    return RedirectToAction("Index", "Teacher", new { area = "admin" });
                }
            }
            return View();
        }



        [HttpGet]
        [Route("assignTeacherSubject/{id}")]
        public IActionResult AssignTeacherSubject(int id)
        {

            var assignTeacherSubjectVM = new TeacherSubjectViewModel();

            var Teacher = _TeacherRepository.FindTeacherById(id);

            assignTeacherSubjectVM.Teacher_Id = Teacher.Teacher_Id;
            assignTeacherSubjectVM.Teacher_Name = Teacher.Teacher_Name;


            assignTeacherSubjectVM.Subjects = _TeacherSubjectRepository.GetAllSubjects();

            assignTeacherSubjectVM.Classes = new List<SelectListItem>();

            var objClass = _TeacherSubjectRepository.GetAllClasses();

            foreach (var lstclass in objClass)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                assignTeacherSubjectVM.Classes.Add(selectListItem);
            }

            assignTeacherSubjectVM.Sections = new List<SelectListItem>();

            var objSection = _TeacherSubjectRepository.GetAllSections();

            foreach (var lstSection in objSection)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                assignTeacherSubjectVM.Sections.Add(selectListItem);
            }


            return View(assignTeacherSubjectVM);

            
        }


        [HttpPost]
        [Route("assignTeacherSubject/{id}")]
        public async Task<IActionResult> AssignTeacherSubject(TeacherSubjectViewModel objVM)
        {

            if (ModelState.IsValid)
            {
                List<string> lstSubject = Request.Form["lstSubject"].ToList();


                var ClassSection = await _TeacherSubjectRepository.GetClassSectionById(objVM.Class_Id, objVM.Section_Id);

                if(ClassSection != null)
                {
                    int result = 0;

                    if (lstSubject.Count > 0)
                    {

                        foreach (var objSubject in lstSubject)
                        {

                            var ClassSubject = await _TeacherSubjectRepository.GetClassSubjectById(ClassSection.ClassSection_id, Convert.ToInt32(objSubject));

                            if(ClassSubject != null)
                            {
                                var TeacherSubject = new TeacherSubject
                                {
                                    Teacher_Id = objVM.Teacher_Id,
                                    ClassSubject_Id = ClassSubject.ClassSubject_Id

                                };

                               result = await _TeacherSubjectRepository.AddTeacherSubject(TeacherSubject);
                            }
                            else
                            {
                                TempData["Error"] = "Please Assign Subject To Class";
                                return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                            }

                        }

                        if (result > 0)
                        {
                            TempData["Success"] = "Subject Assign To Teacher Successfully";
                            return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                        }
                        else
                        {
                            TempData["Error"] = "Failed To Assign Subject To Teacher";
                            return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                        }

                    }

                    //return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Class Section Didn't Find";
                    return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                }
            }

            return View();


        }



        [HttpPost]
        [Route("deleteTeacherSubject")]
        public async Task<IActionResult> DeleteTeacherSubject(int TeacherSubject_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _TeacherSubjectRepository.DeleteTeacherSubject(TeacherSubject_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Teacher Subject Deleted Successfully";
                    return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Failed To Delete Teacher Subject";
                    return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                }

            }

            return View();
        }


        [HttpGet]
        [Route("editTeacherSubject/{id}")]
        public async Task<IActionResult> EditTeacherSubject(int id)
        {
            var objTeacherSubject = await _TeacherSubjectRepository.GetTeacherSubjectById(id);

            return new JsonResult(objTeacherSubject);

        }

        [HttpPost]
        [Route("editTeacherSubject")]
        public async Task<IActionResult> EditTeacherSubject(TeacherSubjectViewModel objTeacherSubjectVM)
        {
            if (ModelState.IsValid)
            {
               // List<string> lstSubject = Request.Form["lstSubject"].ToList();


                var ClassSection = await _TeacherSubjectRepository.GetClassSectionById(objTeacherSubjectVM.Class_Id, objTeacherSubjectVM.Section_Id);

                if (ClassSection != null)
                {
                    int result = 0;
                    
                    var ClassSubject = await _TeacherSubjectRepository.GetClassSubjectById(ClassSection.ClassSection_id, Convert.ToInt32(objTeacherSubjectVM.Subject_Id));

                    if (ClassSubject != null)
                    {
                        var TeacherSubject = new TeacherSubject();

                        TeacherSubject.TeacherSubject_Id = objTeacherSubjectVM.TeacherSubject_Id;
                        TeacherSubject.Teacher_Id = objTeacherSubjectVM.Teacher_Id;
                        TeacherSubject.ClassSubject_Id = ClassSubject.ClassSubject_Id;

                        

                        result = await _TeacherSubjectRepository.EditTeacherSubject(TeacherSubject);

                        if (result > 0)
                        {
                            TempData["Success"] = "Teacher Subject Updated Successfully";
                            return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                        }
                        else
                        {
                            TempData["Error"] = "Failed To Update Teacher Subject";
                            return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                        }

                    }
                    else
                    {
                        TempData["Error"] = "Please Assign Subject To Class";
                        return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                    }

                   
                }
                else
                {
                    TempData["Error"] = "Class Section Didn't Find";
                    return RedirectToAction("teacherSubjectDetail", "teacher", new { area = "admin" });
                }
            }

            return View();

        }



        [HttpGet]
        [Route("teacherSubjectDetail")]
        public IActionResult TeacherSubjectDetail()
        {
            var objTeacherSubjectDetail = _TeacherSubjectRepository.GetTeacherSubjects();

            ViewBag.Class = _TeacherSubjectRepository.GetAllClasses();
            ViewBag.Section = _TeacherSubjectRepository.GetAllSections();
            ViewBag.Subjects = _TeacherSubjectRepository.GetAllSubjects();

            return View(objTeacherSubjectDetail);
        }


        [HttpGet]
        [Route("teacherClassesSubjects")]
        public IActionResult TeacherClassesSubjects(int id)
        {
            var TeacherClassSubject = _TeacherSubjectRepository.GetTeacherClassSubjectstByTeacherId(id);

            return View(TeacherClassSubject);
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