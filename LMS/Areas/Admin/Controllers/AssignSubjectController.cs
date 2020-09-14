using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Admin.Controllers
{
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

            return View(ClassSubject);
        }

        [HttpGet]
        [Route("addClassSubject")]
        public IActionResult AddClassSubject()
        {
            //List<Subject> lstSubject = _AssignSubjectRepository.GetAllSubjects();
            //List<Class> lstClass = _AssignSubjectRepository.GetAllClasses().ToList();


            var assignSubjectVM = new AssignSubjectViewModel();

           // assignSubjectVM.ClassSubject = new ClassSubject();

            assignSubjectVM.Subjects = _AssignSubjectRepository.GetAllSubjects();

            //Fille DropDown List OF Class
            assignSubjectVM.Classes = new List<SelectListItem>();
            //assignSubjectVM.Classes = _AssignSubjectRepository.GetAllClasses();
            //assignSubjectVM.Classes.Insert(0, new Class { Class_Id = 0, Class_Name = "Select Class Name" });

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



            //Fille DropDown List OF Section
            assignSubjectVM.Sections = new List<SelectListItem>();
            //assignSubjectVM.Sections = _AssignSubjectRepository.GetAllSections();
            //assignSubjectVM.Sections.Insert(0, new Section { Section_Id = 0, Section_Name = "Select Section Name" });

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
        public IActionResult AddClassSubject(AssignSubjectViewModel objAssignSubjectVM)
        {
            var assignSubjectVM = new AssignSubjectViewModel();

            //assignSubjectVM.ClassSubject = new ClassSubject();

            assignSubjectVM.Subjects = _AssignSubjectRepository.GetAllSubjects();

            //Fille DropDown List OF Class
            //assignSubjectVM.Classes = new List<Class>();
            //assignSubjectVM.Classes = _AssignSubjectRepository.GetAllClasses().ToList();
            //assignSubjectVM.Classes.Insert(0, new Class { Class_Id = 0, Class_Name = "Select Class Name" });


            //Fille DropDown List OF Section
            //assignSubjectVM.Sections = new List<Section>();
            //assignSubjectVM.Sections = _AssignSubjectRepository.GetAllSections().ToList();
            //assignSubjectVM.Sections.Insert(0, new Section { Section_Id = 0, Section_Name = "Select Section Name" });



            return View(assignSubjectVM);
        }


    }
}