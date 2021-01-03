using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class AssessmentType
    {
        [Key]
        public int Assessment_Type_Id { get; set; }
        public string Assessment_Type_Name { get; set; }

    }
}
