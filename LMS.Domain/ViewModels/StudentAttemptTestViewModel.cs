using System;

namespace LMS.Domain.ViewModels
{
    public class StudentAttemptTestViewModel
    {
        public int Student_Id { get; set; }
        public int Test_Id { get; set; }
        public string Student_Name { get; set; }
        public DateTime SubmittedOn { get; set; }

        //Added By Absar
        public double Obtained_Marks { get; set; }
    }
}
