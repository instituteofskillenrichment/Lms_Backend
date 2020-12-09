using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class StudentAttendanceViewModel
    {
        
        public int Student_Id { get; set; }

        public string Student_Name { get; set; }

        public int Subject_Id { get; set; }

        public string Subject_Name { get; set; }

        public int Class_Id { get; set; }

        public string Class_Name { get; set; }

        public int Section_Id { get; set; }

        public string Section_Name { get; set; }

        public int Session_Id { get; set; }

        public string Session_Name { get; set; }

        public DateTime Session_Date { get; set; }

        public string Attendance_Status { get; set; }

        public DateTime Attendance_Date { get; set; }

    }
}
