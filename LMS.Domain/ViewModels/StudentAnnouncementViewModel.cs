using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class StudentAnnouncementViewModel
    {
        public int Announcement_Id { get; set; }
        public string Announcement_Detail { get; set; }
        public DateTime Announcement_Date { get; set; }
        public int ClassSubject_Id { get; set; }
        public int ClassSection_Id { get; set; }
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
        public int Section_Id { get; set; }
        public string Section_Name { get; set; }
    }
}
