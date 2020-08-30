using System.ComponentModel.DataAnnotations;

namespace LMS.Domain
{
    public class Student
    {
        [Key]
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
    }
}
