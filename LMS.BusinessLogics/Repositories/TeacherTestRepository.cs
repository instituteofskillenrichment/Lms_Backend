﻿using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class TeacherTestRepository : ITeacherTestRepository
    {
        private LmsDbContext _lmsDbContext;

        public TeacherTestRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public IQueryable<TestType> GetAllTestType()
        {
            IQueryable<TestType> listOfTestType = _lmsDbContext.TestType.AsQueryable();

            return listOfTestType;
        }

        public async Task<int> AddTeacherTestDetail(TestDetail objTestDetail)
        {
            try
            {
                await _lmsDbContext.TestDetail.AddAsync(objTestDetail);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;

            }
        }

        public async Task<int> AddTeacherTest(Test objTest)
        {
            try
            {
                await _lmsDbContext.Test.AddAsync(objTest);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IEnumerable<TestListViewModel> GetTestsByTeacher(int TeacherId)
        {
            var Tests = (
                            from t in _lmsDbContext.Test
                            where t.Teacher_Id == TeacherId
                            orderby t.Assessment_Date descending
                            select new TestListViewModel
                            {
                                Test_Id = t.Test_Id,
                                Test_Name = t.Test_Name,
                                Attempts =
                                (from std in _lmsDbContext.StudentTestDetail
                                 join sc in _lmsDbContext.StudentClass on std.Student_Id equals sc.Student_Id
                                 join cs in _lmsDbContext.ClassSection on sc.ClassSection_id equals cs.ClassSection_id
                                 where std.Test_Id == t.Test_Id
                                  && t.Class_Id == cs.Class_Id
                                  && t.Section_Id == cs.Section_Id
                                 select new
                                 {
                                     //std.Answer
                                     std.Student_Id
                                 }).Distinct().Count(p => p.Student_Id >= 0),
                                //.Distinct().Count(p => p.Answer != null),
                                Class_Name = t.Class.Class_Name,
                                Section_Name = t.Section.Section_Name,
                                Subject_Name = t.Subject.Subject_Name,
                                Assessment_Date = DateTime.ParseExact(t.Assessment_Date, "yyyyMMdd", null),
                                Questions_Count =
                                (from td in _lmsDbContext.TestDetail
                                 where td.Test_Id == t.Test_Id
                                 select new
                                 {
                                     td.Question_Name
                                 }).Count(p => p.Question_Name != null)
                            }).ToList();
            return Tests;
        }

        public IEnumerable<TestDetailViewModel> GetQuestionsByTest(int TestId)
        {
            var Questions = (
                           from t in _lmsDbContext.TestDetail
                           where t.Test_Id == TestId
                           select new TestDetailViewModel
                           {
                               Question_Id = t.Question_Id,
                               Question_Name = t.Question_Name,
                               Options_Count = t.Test_Type_Id != 1 ? 0 : string.IsNullOrEmpty(t.Option_2) ? 1 : string.IsNullOrEmpty(t.Option_3) ? 2 : string.IsNullOrEmpty(t.Option_4) ? 3 : 4,
                               Options_Marks = t.Question_Marks
                           }).ToList();

            return Questions;
        }

        public async Task<Test> GetTestById(int Id)
        {
            var Test = await _lmsDbContext.Test
                      .AsNoTracking()
                      .FirstOrDefaultAsync(t => t.Test_Id == Id);

            return Test;
        }

        public async Task<TestDetail> GetQuestionById(int Id)
        {
            var Question = await _lmsDbContext.TestDetail
                      .AsNoTracking()
                      .FirstOrDefaultAsync(q => q.Question_Id == Id);

            return Question;
        }

        public async Task DeleteTest(int TestId)
        {
            var deleteTest = await GetTestById(TestId);

            _lmsDbContext.Test.Remove(deleteTest);

            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task DeleteQuestion(int QuestionId)
        {
            var deleteQuestion = await GetQuestionById(QuestionId);

            _lmsDbContext.TestDetail.Remove(deleteQuestion);

            await _lmsDbContext.SaveChangesAsync();
        }

        public async Task<int> UpdateTeacherTestDetail(TestDetail objTestDetail)
        {
            try
            {
                _lmsDbContext.TestDetail.Update(objTestDetail);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public async Task<int> UpdateTeacherTest(Test objTest)
        {
            try
            {
                _lmsDbContext.Test.Update(objTest);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IEnumerable<StudentAttemptTestViewModel> GetStudentsByTest(int TestId)
        {
            var Students = (
                            from std in _lmsDbContext.StudentTestDetail
                            where std.Test_Id == TestId
                            group std by new
                            {
                                std.Test_Id,
                                std.Student_Id,
                                std.Student.Student_Name,
                                std.SubmittedOn
                            } into g
                            select new StudentAttemptTestViewModel
                            {
                                Test_Id = g.Key.Test_Id,
                                Student_Id = g.Key.Student_Id,
                                Student_Name = g.Key.Student_Name,
                                SubmittedOn = DateTime.ParseExact(g.Key.SubmittedOn, "yyyyMMdd", null),
                                Obtained_Marks = g.Sum(p => p.Marks_Obtained)
                            }).ToList();

            return Students;
        }

        public IEnumerable<StudentTestResultViewModel> GetStudentTestResult(int StudentId, int TestId)
        {
            var TestResult = (
                                from std in _lmsDbContext.StudentTestDetail
                                join t in _lmsDbContext.TestDetail 
                                on new { std.Test_Id, std.Question_Id } equals new { t.Test_Id, t.Question_Id }
                                where std.Test_Id == TestId && std.Student_Id == StudentId
                                select new StudentTestResultViewModel
                                {
                                    Test_Id = std.Test_Id,
                                    Student_Id = std.Student_Id,
                                    Student_Name = std.Student.Student_Name,
                                    Question = t.Question_Name,
                                    Answer = std.Answer,
                                    CorrectAnswer = t.Correct_Answer ?? "Subjected on Teacher",
                                    Answer_Type_Id = std.Answer_Type_Id,
                                    Marks_Obtained = std.Marks_Obtained,
                                    Marks = t.Question_Marks,
                                    Question_Id = std.Question_Id
                                }
                             ).ToList();

            return TestResult;
        }

        public async Task<StudentTestDetail> GetStudentTestDetailById(int StudentId, int TestId, int QuestionId)
        {
            var studentTestDetail = await _lmsDbContext.StudentTestDetail
                     .AsNoTracking()
                     .FirstOrDefaultAsync(s => s.Student_Id == StudentId && s.Test_Id == TestId && s.Question_Id == QuestionId);

            return studentTestDetail;
        }

        public async Task<int> UpdateStudentTestDetail(StudentTestDetail objStudentTestDetail)
        {
            try
            {
                _lmsDbContext.StudentTestDetail.Update(objStudentTestDetail);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<AssessmentType> GetAllAssessmentType()
        {
            IQueryable<AssessmentType> listOfAssessmentType = _lmsDbContext.AssessmentType.AsQueryable();

            return listOfAssessmentType;
        }

        public async Task<int> GetTestTotalMarks(int Id)
        {
            var Marks = await _lmsDbContext.Test
                      .AsNoTracking()
                      .FirstOrDefaultAsync(t => t.Test_Id == Id);

            return Marks.Total_Makrs;
        }


        public async Task<int> AddAssessmentType(AssessmentType objAssessment)
        {
            try
            {
                await _lmsDbContext.AssessmentType.AddAsync(objAssessment);
                await _lmsDbContext.SaveChangesAsync();

                return 1;

            }
            catch (Exception ex)
            {
                // _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;

            }
        }


        public async Task<AssessmentType> GetAssessmentById(int Id)
        {
            var Assessment = await _lmsDbContext.AssessmentType
                        .AsNoTracking()
                        .FirstOrDefaultAsync(a => a.Assessment_Type_Id == Id);

            return Assessment;
        }


        public async Task<int> UpdateAssessmentType(AssessmentType objAssessment)
        {
            try
            {
                _lmsDbContext.AssessmentType.Update(objAssessment);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }


        public async Task<int> DeleteAssessmentType(int id)
        {
            try
            {
                var deleteAssessment = await GetAssessmentById(id);

                _lmsDbContext.AssessmentType.Remove(deleteAssessment);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }
}
