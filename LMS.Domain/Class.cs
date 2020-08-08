using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Class
    {
        [Key]
        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
    }
}
