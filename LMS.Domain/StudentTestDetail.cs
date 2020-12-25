using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace LMS.Domain
{
    public class StudentTestDetail
    {
        [Key]
        public int Answer_Id { get; set; }

        public string Answer { get; set; }

        public Test Test { get; set; }
        
        public int Test_Id { get; set; }

        public Student Student { get; set; }

        public int Student_Id { get; set; }

        public TestDetail TestDetail { get; set; }
        
        public int Question_Id { get; set; }

        [ForeignKey("AnswerType")]
        public int Answer_Type_Id { get; set; }

        public TestType AnswerType { get; set; }

        public int Marks_Obtained { get; set; }

        [Column(TypeName = "DateTime")]
        public DateTime SubmittedOn { get; set; }
    }
}
