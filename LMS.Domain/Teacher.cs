using System.ComponentModel.DataAnnotations;

namespace LMS.Domain
{
    public class Teacher
    {
        [Key]
        public int Teacher_Id { get; set; }
        public string Teacher_Name { get; set; }
        public string Teacher_Cnic { get; set; }
        public string Teacher_DOB { get; set; }
        public string Teacher_Gender { get; set; }
        public string Teacher_MobNumber { get; set; }
        public string Teacher_Email { get; set; }
        public string Teacher_FatherName { get; set; }
        public string Teacher_Designation { get; set; }
        public string Teacher_Department { get; set; }
        public string Teacher_LastDegree { get; set; }
        public string Teacher_CurrentAddress { get; set; }
        public string Teacher_PermenentAddress { get; set; }
        public string Teacher_HomePhone { get; set; }
        public string Teacher_City { get; set; }
        public string Teacher_Country { get; set; }
        public string Teacher_Photo { get; set; }
        





    }
}
