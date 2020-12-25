using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LMS.Areas.Teachers.Models;
using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using Test = LMS.Domain.Test;

namespace LMS.Areas.Teachers.Controllers
{
    [Area("teachers")]
    [Route("teachers/test")]
    public class TestController : Controller
    {
        private readonly ITeacherTestRepository _TeacherTestRepository;
        private readonly IClassRepository _ClassRepository;
        private readonly ISectionRepository _SectionRepository;
        private readonly ISubjectRepository _SubjectRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;

        public TestController(ITeacherTestRepository TeacherTestRepository, IClassRepository ClassRepository,
            ISectionRepository SectionRepository, ISubjectRepository SubjectRepository, IHostingEnvironment hostingEnvironment,
            IConfiguration config)
        {
            _TeacherTestRepository = TeacherTestRepository;
            _ClassRepository = ClassRepository;
            _SectionRepository = SectionRepository;
            _SubjectRepository = SubjectRepository;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        public IActionResult Index()
        {
            var Tests = _TeacherTestRepository.GetTestsByTeacher(HttpContext.Session.GetInt32("UserId") ?? 2);

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

        [Route("addtest")]
        public IActionResult AddTest()
        {
            List<Class> classList = _ClassRepository.GetAllClass().ToList();

            ViewBag.ClassList = classList;

            List<Section> sectionList = _SectionRepository.GetAllSection().ToList();

            ViewBag.SectionList = sectionList;

            List<Subject> subjectList = _SubjectRepository.GetAllSubject().ToList();

            ViewBag.SubjectList = subjectList;

            return View();
        }

        [Route("addtest")]
        [HttpPost]
        public async Task<IActionResult> AddTest(TestViewModel objTest)
        {
            if (ModelState.IsValid)
            {
                Test newTest = new Test
                {
                    Test_Name = objTest.Test_Name,
                    Test_Instruction = objTest.Test_Instruction,
                    Start_Time = objTest.Start_Time.ToString(),
                    End_Time = objTest.End_Time.ToString(),
                    Total_Makrs = objTest.Total_Makrs,
                    Passing_Makrs = objTest.Passing_Makrs,
                    Weighatge = objTest.Weighatge,
                    Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 2,
                    Class_Id = objTest.Class_Id,
                    Section_Id = objTest.Section_Id,
                    Subject_Id = objTest.Subject_Id
                };

                await _TeacherTestRepository.AddTeacherTest(newTest);

                return RedirectToAction("Index", "Test", new { area = "Teachers" });
            }

            return View();
        }

        [Route("edittestdetails/{id}")]
        public async Task<IActionResult> EditTestDetail(int id)
        {
            var objTest = await _TeacherTestRepository.GetQuestionById(id);

            TestDetail model = new TestDetail();

            if (objTest.Test_Type_Id == 3)
            {
                model.Question_Id = objTest.Question_Id;
                model.Question_Name = objTest.Question_Name;
                model.File = objTest.File;
                model.Option_2 = objTest.Option_2;
                model.Option_3 = objTest.Option_3;
                model.Option_4 = objTest.Option_4;
                model.Correct_Answer = objTest.Correct_Answer;
                model.Test_Id = objTest.Test_Id;
                model.Test_Type_Id = objTest.Test_Type_Id;
            }
            else
            {
                model.Question_Id = objTest.Question_Id;
                model.Question_Name = objTest.Question_Name;
                model.Option_1 = objTest.Option_1;
                model.Option_2 = objTest.Option_2;
                model.Option_3 = objTest.Option_3;
                model.Option_4 = objTest.Option_4;
                model.Correct_Answer = objTest.Correct_Answer;
                model.Test_Id = objTest.Test_Id;
                model.Test_Type_Id = objTest.Test_Type_Id;
            }


            List<Class> classList = _ClassRepository.GetAllClass().ToList();

            ViewBag.ClassList = classList;

            List<Section> sectionList = _SectionRepository.GetAllSection().ToList();

            ViewBag.SectionList = sectionList;

            List<Subject> subjectList = _SubjectRepository.GetAllSubject().ToList();

            ViewBag.SubjectList = subjectList;

            List<TestType> testTypeList = _TeacherTestRepository.GetAllTestType().ToList();

            ViewBag.TestTypeList = testTypeList;

            List<string> correctAnswerList = new List<string> { "A", "B", "C", "D" };

            ViewBag.CorrectAnswerList = correctAnswerList;

            return View(model);
        }

        [Route("edittestdetails")]
        [HttpPost]
        public async Task<IActionResult> EditTestDetail()
        {
            if (ModelState.IsValid)
            {
                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<Models.Test>(test);

                TestDetail newTestDetail = await _TeacherTestRepository.GetQuestionById(Convert.ToInt32(TempData["Question_Id"] ?? 1));

                if (root.TestTypeId == "3")
                {
                    dynamic file;

                    string uniqueFileName = string.Empty;

                    if (Request.Form.Files.Count > 0)
                    {
                        file = Request.Form.Files[0];
                        if (newTestDetail.Option_1 != null)
                        {
                            string filePath = Path.Combine(_hostingEnvironment.WebRootPath, "Tests", newTestDetail.Option_1);
                            System.IO.File.Delete(filePath);
                        }
                        uniqueFileName = Utility.ProcessUploadedFile(file, _hostingEnvironment, "Tests");
                        newTestDetail.Option_1 = uniqueFileName;
                    }
                }
                else
                {
                    newTestDetail.Option_1 = root.Option1;
                }

                newTestDetail.Question_Name = root.Question;
                newTestDetail.Option_2 = root.Option2;
                newTestDetail.Option_3 = root.Option3;
                newTestDetail.Option_4 = root.Option4;
                newTestDetail.Correct_Answer = root.CorrectAns;
                newTestDetail.Test_Type_Id = Convert.ToInt32(root.TestTypeId);

                await _TeacherTestRepository.UpdateTeacherTestDetail(newTestDetail);

                return RedirectToAction("Index", "Test", new { area = "Teachers" });
            }

            return View();
        }

        [Route("addtestdetails")]
        public IActionResult AddTestDetails(int id)
        {
            List<TestType> testTypeList = _TeacherTestRepository.GetAllTestType().ToList();

            ViewBag.TestTypeList = testTypeList;

            ViewBag.TestId = id;

            return View();
        }

        [Route("addtestdetails")]
        [HttpPost]
        public async Task<IActionResult> AddTestDetails()
        {
            try
            {
                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<List<Models.Test>>(test);

                if (ModelState.IsValid)
                {
                    for (int i = 0; i < root.Count; i++)
                    {
                        TestDetail newTestDetail = new TestDetail();

                        if (root[i].TestTypeId == "3")
                        {
                            dynamic file;
                            string uniqueFileName = string.Empty;

                            if (Request.Form.Files.Count > 0)
                            {
                                file = Request.Form.Files[0];
                                uniqueFileName = Utility.ProcessUploadedFile(file, _hostingEnvironment, "Tests");
                            }
                            newTestDetail.Question_Name = root[i].Question;
                            newTestDetail.Option_1 = uniqueFileName;
                            newTestDetail.Option_2 = root[i].Option2;
                            newTestDetail.Option_3 = root[i].Option3;
                            newTestDetail.Option_4 = root[i].Option4;
                            newTestDetail.Correct_Answer = root[i].CorrectAns;
                            newTestDetail.Test_Type_Id = Convert.ToInt32(root[i].TestTypeId);
                        }
                        else
                        {
                            newTestDetail.Question_Name = root[i].Question;
                            newTestDetail.Option_1 = root[i].Option1;
                            newTestDetail.Option_2 = root[i].Option2;
                            newTestDetail.Option_3 = root[i].Option3;
                            newTestDetail.Option_4 = root[i].Option4;
                            newTestDetail.Correct_Answer = root[i].CorrectAns;
                            newTestDetail.Test_Type_Id = Convert.ToInt32(root[i].TestTypeId);
                        }

                        newTestDetail.Test_Id = Convert.ToInt32(TempData["TestId"] ?? 1);

                        await _TeacherTestRepository.AddTeacherTestDetail(newTestDetail);
                    }

                    return RedirectToAction("Index", "Test", new { area = "Teachers" });

                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }

            return View();
        }

        [Route("managetest")]
        public IActionResult ManageTest(int id)
        {
            var Questions = _TeacherTestRepository.GetQuestionsByTest(id);

            ViewBag.TestId = id;

            return View(Questions);
        }

        [HttpPost]
        [Route("deleteTest")]
        public async Task<IActionResult> DeleteTest(int Test_Id)
        {
            await _TeacherTestRepository.DeleteTest(Test_Id);

            return RedirectToAction("Index", "Test", new { area = "Teachers" });

        }

        [HttpPost]
        [Route("deleteQuestion")]
        public async Task<IActionResult> DeleteQuestion(int Question_Id)
        {
            await _TeacherTestRepository.DeleteQuestion(Question_Id);

            return RedirectToAction("Index", "Test", new { area = "Teachers" });

        }

        [Route("students")]
        public IActionResult Students(int id)
        {
            var Students = _TeacherTestRepository.GetStudentsByTest(id);

            ViewBag.TestId = id;

            return View(Students);
        }

        [Route("viewTestResult")]
        public IActionResult ViewTestResult(int studentId, int testId)
        {
            var TestResults = _TeacherTestRepository.GetStudentTestResult(studentId, testId);

            TestResults.ToList().ForEach(x => x.Answer = x.Answer_Type_Id == 3 ? _config.GetSection("AppSettings").GetSection("AnswerFilesPath").Value + x.Answer : x.Answer);

            ViewBag.TestId = testId;

            return View(TestResults);
        }
    }
}