using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class SpProgressReportByStudentId
    {
        [Key]
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
        public int Total_Makrs { get; set; }
        public int Marks_Obtained { get; set; }
        public int Total_Weightage { get; set; }
        public decimal? Weightage_Score { get; set; }
        public string Grade { get; set; }
        public int Class_Id { get; set; }
        public int Section_Id { get; set; }
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
    }
}
