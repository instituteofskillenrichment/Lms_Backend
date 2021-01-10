namespace LMS.Domain.ViewModels
{
    public class StudentGradeViewModel
    {
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
        public int Test_id { get; set; }    //Added By Absar
        public string Test_Name { get; set; }   //Added By Absar
        public double? Obtained_Marks { get; set; }
        public double? Total_Marks { get; set; }
        public string Grade { get; set; }
    }
}
