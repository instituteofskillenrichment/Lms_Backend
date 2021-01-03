using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MimeKit;

namespace LMS.Areas.Students.Controllers
{
    [Authorize(Roles = "Student")]
    [Area("students")]
    [Route("students/lecture")]
    public class LectureController : Controller
    {
        private readonly ISPSubjectLectureRepository _SPSubjectLecture;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;

        public LectureController(ISPSubjectLectureRepository SPSubjectLecture, 
                                 IHostingEnvironment hostingEnvironment,
                                 IConfiguration config)
        {
            _SPSubjectLecture = SPSubjectLecture;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        [Route("lectures")]
        public async Task<IActionResult> Lectures(int ClassSubjectId)
        {
            var Lectures = await _SPSubjectLecture.GetAllSubjectLecture(ClassSubjectId);
            
            return View(Lectures);
        }

        [HttpGet]
        [Route("downloadLecture")]
        public async Task<IActionResult> DownloadLecture(int lectureId)
        {
            var lectureFile = await _SPSubjectLecture.GetLectureById(lectureId);

            //string fileName = lectureFile.Lecture_File.Split('_')[1];
            string fileName = lectureFile.ExistingFilePath.Split('_')[1];

            //lectureFile.Lecture_File = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.Lecture_File;
            lectureFile.ExistingFilePath = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.ExistingFilePath;

            // return PhysicalFile(lectureFile.Lecture_File, MimeTypes.GetMimeType(lectureFile.Lecture_File), fileName);
            return PhysicalFile(lectureFile.ExistingFilePath, MimeTypes.GetMimeType(lectureFile.ExistingFilePath), fileName);
        }
    }
}