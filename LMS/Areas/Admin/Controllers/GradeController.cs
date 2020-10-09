using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/grade")]
    public class GradeController : Controller
    {
        private readonly IGradeRepository _GradeRepository;

        public GradeController(IGradeRepository GradeRepository)
        {
            _GradeRepository = GradeRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Grade = _GradeRepository.GetAllGrades();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Grade);
        }


        [HttpGet]
        [Route("addGrade")]
        public IActionResult AddGrade()
        {
            var GradeVM = new GradeViewModel();
            GradeVM.Subjects = _GradeRepository.GetAllSubjects();
            GradeVM.Classes = _GradeRepository.GetAllClasses();
            
            return View(GradeVM);
        }


        [HttpPost]
        [Route("addGrade")]
        public async Task<IActionResult> AddGrade(GradeViewModel objGradetVM)
        {
            if (ModelState.IsValid)
            {
                List<string> lstClass = Request.Form["lstClass"].ToList();
                List<string> lstSubject = Request.Form["lstSubject"].ToList();

                if(lstClass != null && lstSubject != null)
                {

                    List<Grade> grade = new List<Grade>();

                    foreach (var objClass in lstClass)
                    {
                        foreach(var objSubject in lstSubject)
                        {
                            List<GradeViewModel> lstClassSections = new List<GradeViewModel>();
                            lstClassSections = _GradeRepository.GetAllClassSectionByClassId(Convert.ToInt32(objClass));

                            for (int i = 0; i < lstClassSections.Count; i++)
                            {
                                
                                    grade.Add(new Grade
                                    {
                                        Class_Id = lstClassSections[i].Class_Id,
                                        Section_Id = lstClassSections[i].Section_Id,
                                        Subject_Id = Convert.ToInt32(objSubject),
                                        Grade_Name = objGradetVM.Grade_Name,
                                        Start_From = objGradetVM.Start_From,
                                        End_On = objGradetVM.End_On
                                    });
                                
                            }
                        }

                    }


                    int result = await _GradeRepository.AddGrade(grade);

                    if (result == 1)
                    {
                        TempData["Success"] = "Add Grade Successfully";
                        return RedirectToAction("Index", "grade", new { area = "admin" });
                    }
                    else
                    {
                        TempData["Error"] = "Adding Grade Failed";
                        return RedirectToAction("Index", "grade", new { area = "admin" });
                    }


                }
                else
                {
                    TempData["Error"] = "Failed";
                    return RedirectToAction("Index", "grade", new { area = "admin" });
                }
                

            }

            return View();

        }



        [HttpPost]
        [Route("deleteGrade")]
        public async Task<IActionResult> DeleteGrade(int Grade_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _GradeRepository.DeleteGrade(Grade_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Grade Deleted Successfully";
                    return RedirectToAction("Index", "grade", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Grade Failed";
                    return RedirectToAction("Index", "grade", new { area = "admin" });
                }
            }

            return View();

        }


        [HttpGet]
        [Route("editGrade/{id}")]
        public async Task<IActionResult> EditGrade(int id)
        {
            var objGrade = await _GradeRepository.GetGradeById(id);

            return new JsonResult(objGrade);

        }




        [HttpPost]
        [Route("editGrade")]
        public async Task<IActionResult> EditGrade(GradeViewModel gradeModel)
        {
            if (ModelState.IsValid)
            {
                Grade objGrade = await _GradeRepository.GetGradeById(gradeModel.Grade_Id);

                objGrade.Start_From = gradeModel.Start_From;
                objGrade.End_On = gradeModel.End_On;

                int result = await _GradeRepository.UpdateGrade(objGrade);

                if (result == 1)
                {
                    TempData["Success"] = "Grade Updated Successfully";
                    return RedirectToAction("Index", "grade", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updating Grade Failed ";
                    return RedirectToAction("Index", "grae", new { area = "admin" });
                }

            }

            return View();
        }


    }
}