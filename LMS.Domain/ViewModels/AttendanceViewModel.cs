using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class AttendanceViewModel
    {
        public int Session_Id { get; set; }
        public string Session_Name { get; set; }
        public DateTime Session_Date { get; set; }
        public DateTime Session_Start_Time { get; set; }
        public DateTime Session_End_Time { get; set; }


        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
        public int Section_Id { get; set; }
        public string Section_Name { get; set; }
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
        public int Teacher_Id { get; set; }
        public string Teacher_Name { get; set; }
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }

        
        


        public List<AttendanceViewModel> Sessions { get; set; }
        public List<SelectListItem> Classes { get; set; }
        public List<SelectListItem> Sections { get; set; }
        public List<SelectListItem> Subjects { get; set; }

    }
}
