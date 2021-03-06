﻿namespace LMS.Domain.ViewModels
{
    public class StudentTestDetailViewModel
    {
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
        public string Test_Name { get; set; }
        public double Total_Marks { get; set; }
        public double Marks_Obtained { get; set; }
        public string Grade_Name { get; set; }
        public double Total_Weightage { get; set; } //Added By Absar
        public double Weightage_Score { get; set; } //Added By Absar
        public int Class_Id { get; set; } //Added By Absar
        public int Section_Id { get; set; } //Added By Absar
        public int Subject_Id { get; set; } //Added By Absar
    }
}
