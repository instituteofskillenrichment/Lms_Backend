using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Announcement
    {
        [Key]
        public int Announcement_Id { get; set; }
        public string Announcement_Detail { get; set; }
        public string Announcement_Date { get; set; }


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
