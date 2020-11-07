using LMS.Areas.Teachers.Models;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Controllers
{
    [Area("teachers")]
    [Route("teachers/quiz")]
    public class QuizController : Controller
    {
        private readonly ITeacherTestRepository _TeacherTestRepository;
        public QuizController(ITeacherTestRepository TeacherTestRepository)
        {
            _TeacherTestRepository = TeacherTestRepository;
        }

        public IActionResult Index()
        {
            return View();
        }

        [Route("")]
        [Route("addquestions")]
        public IActionResult AddQuestions()
        {
            List<TestType> testTypeList = _TeacherTestRepository.GetAllTestType().ToList();

            ViewBag.TestTypeList = testTypeList;

            return View();
        }

        [Route("")]
        [Route("addquestions")]
        [HttpPost]
        public async Task<IActionResult> AddQuestions(int a)
        {
            

            return View();
        }

    }
}