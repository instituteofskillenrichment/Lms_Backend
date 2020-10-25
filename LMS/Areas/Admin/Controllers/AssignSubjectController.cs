using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/assignSubject")]
    public class AssignSubjectController : Controller
    {

        private readonly IAssignSubjectRepository _AssignSubjectRepository;
        
        public AssignSubjectController(IAssignSubjectRepository AssignSubjectRepository)
        {
            _AssignSubjectRepository = AssignSubjectRepository;
            
        }



        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {

            var ClassSubject = _AssignSubjectRepository.GetAllClassesSubjects();

            ViewBag.Class = _AssignSubjectRepository.GetAllClasses();

            ViewBag.Section = _AssignSubjectRepository.GetAllSections();

            ViewBag.Subject = _AssignSubjectRepository.GetAllSubjects();


            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(ClassSubject);
        }

        [HttpGet]
        [Route("classSubjectDetail/{id}")]
        public IActionResult ClassSubjectDetail(int id)
        {

            var ClassSubject = _AssignSubjectRepository.GetAllSubjectsByClassSection(id);
            
            return View(ClassSubject);
        }



        [HttpGet]
        [Route("addClassSubject")]
        public IActionResult AddClassSubject()
        {
            
            var assignSubjectVM = new AssignSubjectViewModel();

            assignSubjectVM.Subjects = _AssignSubjectRepository.GetAllSubjects();
            
            assignSubjectVM.Classes = new List<SelectListItem>();
            
            var objClass = _AssignSubjectRepository.GetAllClasses().ToList();

            foreach(var lstclass in objClass)
            {
                
                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),
                    
                };
                
                assignSubjectVM.Classes.Add(selectListItem);
            }

            assignSubjectVM.Sections = new List<SelectListItem>();
            
            var objSection = _AssignSubjectRepository.GetAllSections().ToList();

            foreach(var lstSection in objSection)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                assignSubjectVM.Sections.Add(selectListItem);
            }


            return View(assignSubjectVM);
        }


        [HttpPost]
        [Route("addClassSubject")]
        public async Task<IActionResult> AddClassSubject(AssignSubjectViewModel objAssignSubjectVM)
        {
            if (ModelState.IsValid)
            {
                List<string> lstSubject = Request.Form["lstSubject"].ToList();

                
                var ClassSection = await _AssignSubjectRepository.GetClassSectionById(objAssignSubjectVM.Class_Id, objAssignSubjectVM.Section_Id);

                if(ClassSection != null)
                {
                    int result = 0;

                    if (lstSubject.Count > 0)
                    {


                        foreach (var objSubject in lstSubject)
                        {
                            var ClassSubject = new ClassSubject
                            {
                                ClassSection_Id = ClassSection.ClassSection_id,
                                Subject_Id = Convert.ToInt32(objSubject)
                            };


                           result =  await _AssignSubjectRepository.AddClassSubject(ClassSubject);

                        }

                        if(result > 0)
                        {
                            TempData["Success"] = "Assign Subject To Class Successfully";
                            return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                        }
                        else
                        {
                            TempData["Error"] = "Assign Subject To Class Failed";
                            return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                        }


                    }
                }
                else
                {
                    TempData["Error"] = "Kindly First Assign Section To Class";
                    return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                }

                
            }

            return View();
            
        }


        [HttpGet]
        [Route("editClassSubject/{id}")]
        public async Task<IActionResult> EditClassSubject(int id)
        {

            ViewBag.Class = _AssignSubjectRepository.GetAllClasses();

            ViewBag.Section = _AssignSubjectRepository.GetAllSections();

            ViewBag.Subject = _AssignSubjectRepository.GetAllSubjects();


            var objassignSubject = await _AssignSubjectRepository.GetClassSubjectById(id);

            return new JsonResult(objassignSubject);
        }



        [HttpPost]
        [Route("editClassSubject")]
        public async Task<IActionResult> EditClassSubject(AssignSubjectViewModel objClassSubjectModel)
        {
            if (ModelState.IsValid)
            {
                //get values of class subject
                AssignSubjectViewModel objAssignSubject = await _AssignSubjectRepository.GetClassSubjectById(objClassSubjectModel.ClassSubject_Id);

                //get class section id
                var ClassSection = await _AssignSubjectRepository.GetClassSectionById(objClassSubjectModel.Class_Id, objClassSubjectModel.Section_Id);

                if(ClassSection != null)
                {
                    //assign new values to class subject
                    ClassSubject objSubject = new ClassSubject();

                    objSubject.ClassSubject_Id = objAssignSubject.ClassSubject_Id;
                    objSubject.ClassSection_Id = ClassSection.ClassSection_id;
                    objSubject.Subject_Id = objClassSubjectModel.Subject_Id;


                    int result = await _AssignSubjectRepository.UpdateClassSubject(objSubject);
                    if (result == 1)
                    {
                        TempData["Success"] = "Class Subject Updated Successfully ";
                        return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                    }
                    else
                    {
                        TempData["Error"] = "Updating Class Subject Failed";
                        return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                    }
                }
                else
                {
                    TempData["Error"] = "Class Section Didn't Find";
                    return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                }

                

            }

            return View();
        }




        [HttpPost]
        [Route("deleteClassSubject")]
        public async Task<IActionResult> DeleteClassSubject(int ClassSubject_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _AssignSubjectRepository.DeleteClassSubject(ClassSubject_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Class Subject Deleted Successfully";
                    return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Class Subject Failed";
                    return RedirectToAction("Index", "assignSubject", new { area = "admin" });
                }
            }

            return View();
            
        }

    }
}