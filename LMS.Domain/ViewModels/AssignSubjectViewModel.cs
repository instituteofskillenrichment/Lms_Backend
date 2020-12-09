using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class AssignSubjectViewModel
    {
        public int ClassSubject_Id { get; set; }


        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }


        public int Section_Id { get; set; }
        public string Section_Name { get; set; }


        public int Class_Id { get; set; }
        public string Class_Name { get; set; }


        public int ClassSection_Id { get; set; }

        public List<Subject> Subjects { get; set; }
        public List<SelectListItem> Classes { get; set; }
        public List<SelectListItem> Sections { get; set; }


    }
}
