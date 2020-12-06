using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class StudentLectureViewModel
    {
        public int Lecture_Id { get; set; }
        public string Lecture_Name { get; set; }
        public string Lecture_Detail { get; set; }
        public string Lecture_File { get; set; }
        public DateTime LecturePost_Date { get; set; }
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
        public int Section_Id { get; set; }
        public string Section_Name { get; set; }
    }
}
