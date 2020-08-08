using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Section
    {
        [Key]
        public int Section_Id { get; set; }
        public int Section_Name { get; set; }
    }
}
