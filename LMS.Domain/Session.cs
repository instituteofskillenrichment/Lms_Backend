using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Session
    {
        [Key]
        public int Session_Id { get; set; }
        public string Session_Name { get; set; }
        public string Date { get; set; }
        public string Start_Time { get; set; }
        public string End_Time { get; set; }


        public Class Class { get; set; }
        public int Class_Id { get; set; }
        public Section Section { get; set; }
        public int Section_Id { get; set; }
        public Subject Subject { get; set; }
        public int Subject_Id { get; set; }
        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }
    }
}
