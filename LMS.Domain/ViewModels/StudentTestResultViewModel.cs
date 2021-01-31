using System;

namespace LMS.Domain.ViewModels
{
    public class StudentTestResultViewModel
    {
        public int Question_Id { get; set; }
        public int Student_Id { get; set; }
        public int Test_Id { get; set; }
        public string Student_Name { get; set; }
        public string Question { get; set; }
        public string Answer { get; set; }
        public string CorrectAnswer { get; set; }
        public int Answer_Type_Id { get; set; }
        public int Marks_Obtained { get; set; }
        public int Marks { get; set; }
        public double Total_Obtained { get; set; }  //Added By Absar
    }
}
