using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class StudentClass
    {
        [Key]
        public int StudentClass_Id { get; set; }

        public Student Student { get; set; }
        public int Student_Id { get; set; }

        public ClassSection ClassSection { get; set; }
        public int ClassSection_id { get; set; }
    }
}
