using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class AssignSectionViewModel
    {
        
        public int ClassSection_Id { get; set; }
        
        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
        
        public int Section_Id { get; set; }
        public string Section_Name { get; set; }


        public List<Class> Classes = new List<Class>();
        public List<Section> Sections = new List<Section>();
        public List<ClassSection> ClassSections = new List<ClassSection>();
        
        

    }
}
