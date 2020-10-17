using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Test
    {
        [Key]
        public int Test_Id { get; set; }
        public string Test_Name { get; set; }
        public string Test_Instruction { get; set; }
        public string Start_Time { get; set; }
        public string End_Time { get; set; }
        public int Total_Makrs { get; set; }
        public int Passing_Makrs { get; set; }
        public int Weighatge { get; set; }


        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }
        public Class Class { get; set; }
        public int Class_Id { get; set; }
        public Section Section { get; set; }
        public int Section_Id { get; set; }
        public Subject Subject { get; set; }
        public int Subject_Id { get; set; }
    }
}
