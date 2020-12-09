using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Students.Controllers
{
    [Area("students")]
    [Route("students/test")]
    public class TestController : Controller
    {
        private readonly IStudentTestRepository _StudentTestRepository;
        private readonly IStudentClassRepository _StudentClassRepository;
        private readonly IClassRepository _ClassRepository;
        private readonly ISectionRepository _SectionRepository;
        private readonly ISubjectRepository _SubjectRepository;
        private readonly IHostingEnvironment _hostingEnvironment;

        public TestController(IStudentTestRepository StudentTestRepository, IStudentClassRepository StudentClassRepository, IClassRepository ClassRepository,
            ISectionRepository SectionRepository, ISubjectRepository SubjectRepository, IHostingEnvironment hostingEnvironment)
        {
            _StudentTestRepository = StudentTestRepository;
            _StudentClassRepository = StudentClassRepository;
            _ClassRepository = ClassRepository;
            _SectionRepository = SectionRepository;
            _SubjectRepository = SubjectRepository;
            _hostingEnvironment = hostingEnvironment;
        }

        public IActionResult Index()
        {
            var Tests = _StudentClassRepository.GetTestsByStudentId(HttpContext.Session.GetInt32("UserId") ?? 1);

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Tests);
        }

        [Route("attempttest/{id}")]
        public IActionResult AttemptTest(int id)
        {
            var questionsList = _StudentTestRepository.GetQuestionsByTest(id);

            return View(questionsList);
        }

        [Route("attempttest")]
        [HttpPost]
        public async Task<IActionResult> AttemptTest()
        {
            try
            {
                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<List<Models.Answers>>(test);

                if (ModelState.IsValid)
                {
                    for (int i = 0; i < root.Count; i++)
                    {
                        StudentTestDetail newStudentTestDetail = new StudentTestDetail();

                        if (root[i].AnswerTypeId == "3")
                        {
                            dynamic file;
                            string uniqueFileName = string.Empty;

                            if (Request.Form.Files.Count > 0)
                            {
                                file = Request.Form.Files[0];
                                uniqueFileName = Utility.ProcessUploadedFile(file, _hostingEnvironment, "Answers");
                            }
                            newStudentTestDetail.Question_Id = Convert.ToInt32(root[i].QuestionId);
                            newStudentTestDetail.Answer = uniqueFileName;
                            newStudentTestDetail.Test_Id = Convert.ToInt32(root[i].TestId);
                            newStudentTestDetail.Answer_Type_Id = Convert.ToInt32(root[i].AnswerTypeId);
                            newStudentTestDetail.Student_Id = 1;
                            newStudentTestDetail.SubmittedOn = DateTime.Now;
                        }
                        else
                        {
                            newStudentTestDetail.Question_Id = Convert.ToInt32(root[i].QuestionId);
                            newStudentTestDetail.Answer = root[i].Answer;
                            newStudentTestDetail.Test_Id = Convert.ToInt32(root[i].TestId);
                            newStudentTestDetail.Answer_Type_Id = Convert.ToInt32(root[i].AnswerTypeId);
                            newStudentTestDetail.Student_Id = 1;
                            newStudentTestDetail.SubmittedOn = DateTime.Now;
                        }

                        await _StudentTestRepository.AddStudentTestDetail(newStudentTestDetail);
                    }

                    return RedirectToAction("Index", "Test", new { area = "Students" });

                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }

            return View();
        }
    }
}