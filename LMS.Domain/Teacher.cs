using System.ComponentModel.DataAnnotations;

namespace LMS.Domain
{
    public class Teacher
    {
        [Key]
        public int Teacher_Id { get; set; }
        public string Teacher_Name { get; set; }
    }
}
