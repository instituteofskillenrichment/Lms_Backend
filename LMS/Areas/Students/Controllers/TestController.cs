using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.Areas.Students.Controllers
{
    [Authorize(Roles = "Student")]
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
        private readonly IConfiguration _config;

        public TestController(IStudentTestRepository StudentTestRepository, IStudentClassRepository StudentClassRepository, IClassRepository ClassRepository,
            ISectionRepository SectionRepository, ISubjectRepository SubjectRepository, IHostingEnvironment hostingEnvironment,
            IConfiguration config)
        {
            _StudentTestRepository = StudentTestRepository;
            _StudentClassRepository = StudentClassRepository;
            _ClassRepository = ClassRepository;
            _SectionRepository = SectionRepository;
            _SubjectRepository = SubjectRepository;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [Route("index")]
        public IActionResult Index()
        {
            var Tests = _StudentClassRepository.GetTestsByStudentId(HttpContext.Session.GetInt32("UserId") ?? 0);

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
        public async Task<int> AttemptTest()
        {
            try
            {
                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<List<Models.Answers>>(test);

                if (ModelState.IsValid)
                {
                    int result = 0;

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
                            newStudentTestDetail.Student_Id = HttpContext.Session.GetInt32("UserId") ?? 0;
                            newStudentTestDetail.SubmittedOn = DateTime.Now.ToString("yyyyMMdd");
                        }
                        else
                        {
                            newStudentTestDetail.Question_Id = Convert.ToInt32(root[i].QuestionId);
                            newStudentTestDetail.Answer = root[i].Answer;
                            newStudentTestDetail.Test_Id = Convert.ToInt32(root[i].TestId);
                            newStudentTestDetail.Answer_Type_Id = Convert.ToInt32(root[i].AnswerTypeId);
                            newStudentTestDetail.Student_Id = HttpContext.Session.GetInt32("UserId") ?? 0;
                            newStudentTestDetail.SubmittedOn = DateTime.Now.ToString("yyyyMMdd");
                        }

                        result = await _StudentTestRepository.AddStudentTestDetail(newStudentTestDetail);
                    }

                    if (result > 0)
                    {
                        TempData["Success"] = " Assessment Submitted Successfully";
                        return 1;
                    }
                    else
                    {
                        TempData["Error"] = "Assessment Submittion Failed";
                        return -1;
                    }

                    //return RedirectToAction("Index", "Test", new { area = "Students" });
                   
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }

            //return View();
            return -1; 
        }




        [Route("viewResult")]
        public IActionResult ViewResult(int TestId)
        {
            var TestResults = _StudentTestRepository.GetStudentTestResult(TestId, HttpContext.Session.GetInt32("UserId") ?? 0);

            TestResults.ToList().ForEach(x => x.Answer = x.Answer_Type_Id == 3 ? _config.GetSection("AppSettings").GetSection("AnswerFilesPath").Value + x.Answer : x.Answer);

            

            return View(TestResults);
        }
    }
}