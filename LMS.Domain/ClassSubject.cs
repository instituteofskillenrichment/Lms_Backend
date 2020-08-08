using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class ClassSubject
    {
        [Key]
        public int ClassSubject_Id { get; set; }
        
        public Subject Subject { get; set; }
        public int Subject_Id { get; set; }

        public ClassSection ClassSection { get; set; }
        public int ClassSection_Id { get; set; }
    }
}
