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
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;
using Test = LMS.Domain.Test;

namespace LMS.Areas.Teachers.Controllers
{
    [Authorize(Roles = "Teacher")]
    [Area("teachers")]
    [Route("teachers/test")]
    public class TestController : Controller
    {
        private readonly ITeacherTestRepository _TeacherTestRepository;
        //private readonly IClassRepository _ClassRepository;
        //private readonly ISectionRepository _SectionRepository;
        //private readonly ISubjectRepository _SubjectRepository;
        private readonly ILectureRepository _LectureRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;


        public TestController(ITeacherTestRepository TeacherTestRepository, IClassRepository ClassRepository,
            ISectionRepository SectionRepository, ISubjectRepository SubjectRepository, IHostingEnvironment hostingEnvironment,
            IConfiguration config)

        {
            _TeacherTestRepository = TeacherTestRepository;
            //_ClassRepository = ClassRepository;
            //_SectionRepository = SectionRepository;
           // _SubjectRepository = SubjectRepository;
            _LectureRepository = LectureRepository;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Tests = _TeacherTestRepository.GetTestsByTeacher(HttpContext.Session.GetInt32("UserId") ?? 0);

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
		
		
			List<AssessmentType> assessmentTypeList = _TeacherTestRepository.GetAllAssessmentType().ToList();
			ViewBag.AssessmentTypeList = assessmentTypeList;
			
            List<SelectListItem> classList = new List<SelectListItem>();
            classList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                classList.Add(selectListItem);
            }
            ViewBag.ClassList = classList;


            List<SelectListItem> sectionList = new List<SelectListItem>();
            sectionList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                sectionList.Add(selectListItem);
            }
            ViewBag.SectionList = sectionList;

            List<SelectListItem> subjectList = new List<SelectListItem>();
            subjectList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
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
                    Test_Name = objTest.Test_Name.ToUpper(),
                    Test_Instruction = objTest.Test_Instruction,
                    Start_Time = Convert.ToDateTime(objTest.Start_Time).ToString("HHmmss"),
                    End_Time = Convert.ToDateTime(objTest.End_Time).ToString("HHmmss"),
                    Total_Makrs = objTest.Total_Makrs,
                    Passing_Makrs = objTest.Passing_Makrs,
                    Weighatge = objTest.Weighatge,
                    Teacher_Id = HttpContext.Session.GetInt32("UserId") ?? 0,
                    Class_Id = objTest.Class_Id,
                    Section_Id = objTest.Section_Id,
                    Subject_Id = objTest.Subject_Id,
                    Assessment_Type_Id = objTest.Assessment_Type_Id,
                    Assessment_Status = objTest.Assessment_Status,
                    Assessment_Date = Convert.ToDateTime(objTest.Assessment_Date).ToString("yyyyMMdd")
                };

                int result = await _TeacherTestRepository.AddTeacherTest(newTest);
                if (result == 1)
                {
                    TempData["Success"] = " Test Added Successfully";
                    return RedirectToAction("index", "test", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Adding Test Failed";
                    return RedirectToAction("index", "test", new { area = "teachers" });
                }
            }

            return View();
        }


        //Added By Absar
        [HttpGet]
        [Route("editTest/{id}")]
        public async Task<IActionResult> EditTest(int id)
        {
            

            List<AssessmentType> assessmentTypeList = _TeacherTestRepository.GetAllAssessmentType().ToList();
            ViewBag.AssessmentTypeList = assessmentTypeList;

            List<SelectListItem> classList = new List<SelectListItem>();
            classList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                classList.Add(selectListItem);
            }
            ViewBag.ClassList = classList;


            List<SelectListItem> sectionList = new List<SelectListItem>();
            sectionList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                sectionList.Add(selectListItem);
            }
            ViewBag.SectionList = sectionList;


            List<SelectListItem> subjectList = new List<SelectListItem>();
            subjectList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
            ViewBag.SubjectList = subjectList;

            var objTest = await _TeacherTestRepository.GetTestById(id);
            
            return View(objTest);

        }

        
        [HttpPost]
        [Route("editTest/{id}")]
        public async Task<IActionResult> EditTest(Test testModel)
        {
            if (ModelState.IsValid)
            { 

                Test objTest = await _TeacherTestRepository.GetTestById(testModel.Test_Id);

                objTest.Test_Name = testModel.Test_Name.ToUpper();
                objTest.Test_Instruction = testModel.Test_Instruction;
                objTest.Start_Time = Convert.ToDateTime(testModel.Start_Time).ToString("HHmmss");
                objTest.End_Time = Convert.ToDateTime(testModel.End_Time).ToString("HHmmss");
                objTest.Total_Makrs = testModel.Total_Makrs;
                objTest.Passing_Makrs = testModel.Passing_Makrs;
                objTest.Weighatge = testModel.Weighatge;
                objTest.Class_Id = testModel.Class_Id;
                objTest.Section_Id = testModel.Section_Id;
                objTest.Subject_Id = testModel.Subject_Id;
                objTest.Assessment_Type_Id = testModel.Assessment_Type_Id;
                objTest.Assessment_Status = testModel.Assessment_Status;
                objTest.Assessment_Date = Convert.ToDateTime(testModel.Assessment_Date).ToString("yyyyMMdd");

                int result = await _TeacherTestRepository.UpdateTeacherTest(objTest);

                if (result == 1)
                {
                    TempData["Success"] = "Assessment Updated Successfully";
                    return RedirectToAction("index", "test", new { area = "teachers" });
                }
                else
                {
                    TempData["Error"] = "Updating Assessment Failed ";
                    return RedirectToAction("index", "test", new { area = "teachers" });
                }

                
            }

            return View();
        }



        [Route("edittestdetails/{id}")]
        public async Task<IActionResult> EditTestDetail(int id, int testId)
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
                model.Question_Marks = objTest.Question_Marks;
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
                model.Question_Marks = objTest.Question_Marks;
            }


            List<SelectListItem> classList = new List<SelectListItem>();
            classList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objClassSecSub = _LectureRepository.GetAllClassSectionByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstclass in objClassSecSub)
            {

                var selectListItem = new SelectListItem
                {
                    Text = lstclass.Class_Name,
                    Value = lstclass.Class_Id.ToString(),

                };

                classList.Add(selectListItem);
            }
            ViewBag.ClassList = classList;


            List<SelectListItem> sectionList = new List<SelectListItem>();
            sectionList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            foreach (var lstSection in objClassSecSub)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSection.Section_Name,
                    Value = lstSection.Section_Id.ToString(),

                };

                sectionList.Add(selectListItem);
            }
            ViewBag.SectionList = sectionList;

            List<SelectListItem> subjectList = new List<SelectListItem>();
            subjectList.Insert(0, new SelectListItem() { Value = "-1", Text = "--Select--" });
            var objSubject = _LectureRepository.GetAllSubjectByTeacherId(HttpContext.Session.GetInt32("UserId") ?? 0).ToList();
            foreach (var lstSubject in objSubject)
            {
                var selectListItem = new SelectListItem
                {
                    Text = lstSubject.Subject_Name,
                    Value = lstSubject.Subject_Id.ToString(),

                };

                subjectList.Add(selectListItem);
            }
            ViewBag.SubjectList = subjectList;

            List<TestType> testTypeList = _TeacherTestRepository.GetAllTestType().ToList();

            ViewBag.TestTypeList = testTypeList;

            List<string> correctAnswerList = new List<string> { "A", "B", "C", "D" };

            ViewBag.CorrectAnswerList = correctAnswerList;

            var totalMarks = await _TeacherTestRepository.GetTestTotalMarks(testId);

            ViewBag.TotalMarks = totalMarks;

            return View(model);
        }

        [Route("edittestdetails")]
        [HttpPost]
        public async Task<int> EditTestDetail()
        {
            if (ModelState.IsValid)
            {
                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<Models.Test>(test);

                TestDetail newTestDetail = await _TeacherTestRepository.GetQuestionById(Convert.ToInt32(TempData["Question_Id"] ?? 1));

                int result = 0;

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
                newTestDetail.Question_Marks = root.Marks;

                result = await _TeacherTestRepository.UpdateTeacherTestDetail(newTestDetail);
                if (result > 0)
                {
                    TempData["Success"] = "Question Updated Successfully";
                    
                }
                else
                {
                    TempData["Error"] = "Updating Question Failed";
                    
                }

                return 1;
				
            }

            return -1;
			//return View();
        }

        [Route("addtestdetails")]
        public async Task<IActionResult> AddTestDetails(int id)
        {
            List<TestType> testTypeList = _TeacherTestRepository.GetAllTestType().ToList();

            ViewBag.TestTypeList = testTypeList;

            var totalMarks = await _TeacherTestRepository.GetTestTotalMarks(id);

            ViewBag.TotalMarks = totalMarks;

            ViewBag.TestId = id;

            
            
            return View();
            
            
        }

        [Route("addtestdetails")]
        [HttpPost]
        public async Task<int> AddTestDetails()
        {
            
              
            try            
			{

                string test = Request.Form.Where(x => x.Key == "tests").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<List<Models.Test>>(test);

                if (ModelState.IsValid)
                {
                    int result = 0;

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
                            newTestDetail.Question_Marks = root[i].Marks;
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
                            newTestDetail.Question_Marks = root[i].Marks;
                        }

                            newTestDetail.Test_Id = Convert.ToInt32(TempData["TestId"] ?? 1);

                        result = await _TeacherTestRepository.AddTeacherTestDetail(newTestDetail);
                        
                    }
                    
                    if (result > 0)
                    {
                        TempData["Success"] = "Questions Added Successfully";
                        
                    }
                    else
                    {
                        TempData["Error"] = "Adding Questions Failed";
                        
                    }
                
                    return 1;
                    	
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }

            return -1;
			  
            
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
            ViewBag.StudentId = studentId;

            return View(TestResults);
        }

        [Route("viewTestResult")]
        [HttpPost]
        public async Task<IActionResult> ViewTestResult()
        {
            try
            {
                string result = Request.Form.Where(x => x.Key == "results").FirstOrDefault().Value;

                var root = JsonConvert.DeserializeObject<List<Result>>(result);

                if (ModelState.IsValid)
                {
                    for (int i = 0; i < root.Count; i++)
                    {
                        var newStudentTestDetail = await _TeacherTestRepository.GetStudentTestDetailById(Convert.ToInt32(TempData["StudentId"]), Convert.ToInt32(TempData["TestId"]), root[i].QuestionId);
                        
                        newStudentTestDetail.Marks_Obtained = root[i].MarksObtained;

                        await _TeacherTestRepository.UpdateStudentTestDetail(newStudentTestDetail);
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


        //Added By Absar
        [Route("assessments")]
        public IActionResult Assessments()
        {
            var assessmentTypeList = _TeacherTestRepository.GetAllAssessmentType().ToList();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }


            return View(assessmentTypeList);
        }

        [HttpPost]
        [Route("addAssessmentType")]
        public async Task<IActionResult> AddAssessmentType(AssessmentType objAssessment)
        {
            if (ModelState.IsValid)
            {
                AssessmentType newClass = new AssessmentType
                {
                    Assessment_Type_Name = objAssessment.Assessment_Type_Name
                };

                int result = await _TeacherTestRepository.AddAssessmentType(newClass);
                if (result == 1)
                {
                    TempData["Success"] = " Assessment Type Added Successfully";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }
                else
                {
                    TempData["Error"] = "Adding Assessment Type Failed";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }



            }

            return View();
        }


        [HttpGet]
        [Route("editAssessmentType/{id}")]
        public async Task<IActionResult> EditAssessmentType(int id)
        {
            var objAssessment = await _TeacherTestRepository.GetAssessmentById(id);

            return new JsonResult(objAssessment);

        }


        [HttpPost]
        [Route("editAssessmentType")]
        public async Task<IActionResult> EditAssessmentType(AssessmentType assessmentModel)
        {
            if (ModelState.IsValid)
            {
                AssessmentType objAssessment = await _TeacherTestRepository.GetAssessmentById(assessmentModel.Assessment_Type_Id);

                objAssessment.Assessment_Type_Name = assessmentModel.Assessment_Type_Name;
                

                int result = await _TeacherTestRepository.UpdateAssessmentType(objAssessment);

                if (result == 1)
                {
                    TempData["Success"] = "Assessment Type Updated Successfully";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }
                else
                {
                    TempData["Error"] = "Updating Assessment Type Failed ";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }

            }

            return View();
        }


        [HttpPost]
        [Route("deleteAssessmentType")]
        public async Task<IActionResult> DeleteAssessmentType(int Assessment_Type_Id)
        {
            if (ModelState.IsValid)
            {
                int result = await _TeacherTestRepository.DeleteAssessmentType(Assessment_Type_Id); ;

                if (result == 1)
                {
                    TempData["Success"] = "Delete Assessment Type Successfully";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }
                else
                {
                    TempData["Error"] = "Deleting Assessment Type Failed";
                    return RedirectToAction("assessments", "Test", new { area = "Teachers" });
                }
            }

            return View();

        }




    }

    
}