using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Grade
    {
        [Key]
        public int Grade_Id { get; set; }
        public string Grade_Name { get; set; }
        public int Start_From { get; set; }
        public int End_On { get; set; }


        public Class Class { get; set; }
        public int Class_Id { get; set; }
        public Section Section { get; set; }
        public int Section_Id { get; set; }
        public Subject Subject { get; set; }
        public int Subject_Id { get; set; }
    }
}
