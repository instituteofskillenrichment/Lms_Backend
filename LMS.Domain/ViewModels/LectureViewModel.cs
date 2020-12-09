using Microsoft.AspNetCore.Http;
using System;

namespace LMS.Domain.ViewModels
{
    public class LectureViewModel
    {
        public string Lecture_Name { get; set; }
        public string Lecture_Detail { get; set; }
        public IFormFile Lecture_File { get; set; }
        public DateTime LecturePost_Date { get; set; }

        public int Class_Id { get; set; }
        public string Class_Name { get; set; }

        public int Section_Id { get; set; }
        public string Section_Name { get; set; }

        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }

        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }

        public ClassSubject ClassSubject { get; set; }
        public int ClassSubject_Id { get; set; }

    }
}
