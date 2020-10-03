using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class SubjectLectureViewModel
    {
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
        public string Class_Name { get; set; }
        public int Lecture_Count { get; set; }
        public int ClassSubject_Id { get; set; }
    }
}
