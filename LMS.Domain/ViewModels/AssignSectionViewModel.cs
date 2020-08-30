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
        public string ClassName { get; set; }
        
        public int Section_Id { get; set; }
        public string ClassSectionName { get; set; }
        
        public IQueryable<AssignSectionViewModel> assignSectionViewModels { get; set; }

    }
}
