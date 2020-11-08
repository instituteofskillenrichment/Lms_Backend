using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class TestType
    {
        [Key]
        public int Test_Type_Id { get; set; }
        public string Test_Type_Name { get; set; }
      
    }
}
