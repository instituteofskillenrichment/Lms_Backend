
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

using System.Text;

namespace LMS.Domain
{
    public class TestDetail
    {
        [Key]
        public int Question_Id { get; set; }
        public string Question_Name { get; set; }
        public string Option_1 { get; set; }
        public string Option_2 { get; set; }
        public string Option_3 { get; set; }
        public string Option_4 { get; set; }
        public string Correct_Answer { get; set; }

        public Test Test { get; set; }
        public int Test_Id { get; set; }

        public TestType TestType { get; set; }
        public int Test_Type_Id { get; set; }

        [NotMapped]
        public IFormFile File { get; set; }
        

    }
}
