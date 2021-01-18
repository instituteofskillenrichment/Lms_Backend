using System.ComponentModel.DataAnnotations;

namespace LMS.Domain.ViewModels
{
    public class StudentGradeViewModel
    {
        [Key]
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
        public int Test_id { get; set; }    //Added By Absar
        public string Test_Name { get; set; }   //Added By Absar
        public double? Obtained_Marks { get; set; }
        public double? Total_Marks { get; set; }
        public double? Total_Weightage { get; set; }    //Added By Absar
        public double? Weightage_Score { get; set; }    //Added By Absar
        public string Grade { get; set; } 
        public string Class_Id { get; set; }    //Added By Absar
        public string Section_Id { get; set; } //Added By Absar
        public string Subject_Id { get; set; } //Added By Absar


    }
}
