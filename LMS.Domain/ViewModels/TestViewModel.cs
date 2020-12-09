using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class TestViewModel
    {
        public string Test_Name { get; set; }
        public string Test_Instruction { get; set; }
        public DateTime Start_Time { get; set; }
        public DateTime End_Time { get; set; }
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
        public AssessmentType AssessmentType { get; set; }
        public int Assessment_Type_Id { get; set; }
        //Added By Absar
        public int Assessment_Status { get; set; }
        public DateTime Assessment_Date { get; set; }
        
    }
}
