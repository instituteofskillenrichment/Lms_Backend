using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class ClassSection
    {
        [Key]
        public int ClassSection_id { get; set; }

        public Class Class { get; set; }
        public int Class_Id { get; set; }
        
        public Section Section { get; set; }
        public int Section_Id { get; set; }

    }
}
