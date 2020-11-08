using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Attendance
    {
        [Key]
        public int Id { get; set; }
        public string Date { get; set; }
        public string Status { get; set; }
       


        public Session Session { get; set; }
        public int Session_Id { get; set; }

        public Student Student { get; set; }
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }

        public Class Class { get; set; }
        public int Class_Id { get; set; }

        public Section Section { get; set; }
        public int Section_Id { get; set; }

        public Subject Subject { get; set; }
        public int Subject_Id { get; set; }

        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }

    }
}
