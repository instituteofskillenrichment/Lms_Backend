using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class GradeViewModel
    {
        public int Grade_Id { get; set; }
        public string Grade_Name { get; set; }
        public int Start_From { get; set; }
        public int End_On { get; set; }



        public int Class_Id { get; set; }
        public string Class_Name { get; set; }


        public int Section_Id { get; set; }
        public string Section_Name { get; set; }


        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }


        public List<SelectListItem> ClassList { get; set; }
        public List<SelectListItem> SectionsList { get; set; }
        public List<Subject> Subjects { get; set; }
        public List<Class> Classes { get; set; }
    }
}
