using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Lecture
    {
        [Key]
        public int Lecture_Id { get; set; }
        public string Lecture_Name { get; set; }
        public string Lecture_Detail { get; set; }
        public string Lecture_File { get; set; }
        public string LecturePost_Date { get; set; }

        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }

        public ClassSubject ClassSubject { get; set; }
        public int ClassSubject_Id { get; set; }


    }
}
