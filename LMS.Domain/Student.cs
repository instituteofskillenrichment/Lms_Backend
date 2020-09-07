using System.ComponentModel.DataAnnotations;

namespace LMS.Domain
{
    public class Student
    {
        [Key]
        public int Student_Id { get; set; }
        public string Student_Name { get; set; }
        public string Student_Cnic { get; set; }
        public string Student_DOB { get; set; }
        public string Student_Gender { get; set; }
        public string Student_MobNumber { get; set; }
        public string Student_Email { get; set; }
        public string Student_FatherName { get; set; }
        public string Student_CurrentAddress { get; set; }
        public string Student_PermenentAddress { get; set; }
        public string Student_HomePhone { get; set; }
        public string Student_City { get; set; }
        public string Student_Country { get; set; }
        public string Student_Photo { get; set; }

    }
}
