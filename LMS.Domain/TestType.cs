using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace LMS.Domain
{
    public class TestType
    {
        [Key]
        public int Test_Type_Id { get; set; }
        public string Test_Type_Name { get; set; }

        [InverseProperty(nameof(StudentTestDetail.AnswerType))]
        public List<StudentTestDetail> StudentTestDetailAnswerType { get; set; }

    }
}
