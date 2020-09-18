using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class StudentClassViewModel
    {
        public int StudentClass_Id { get; set; }

        public int ClassSection_Id { get; set; }

        public int ClassSubject_Id { get; set; }

        public int Student_Id { get; set; }

        public string Student_Name { get; set; }

        public int Subject_Id { get; set; }

        public string Subject_Name { get; set; }

        public int Class_Id { get; set; }

        public string Class_Name { get; set; }

        public int Section_Id { get; set; }

        public string Section_Name { get; set; }


        public List<Student> Students { get; set; }
        public List<SelectListItem> Classes { get; set; }
        public List<SelectListItem> Sections { get; set; }


    }
}
