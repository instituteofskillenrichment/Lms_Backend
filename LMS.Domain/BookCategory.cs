using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class BookCategory
    {
        [Key]
        public int BookCategory_Id { get; set; }
        public string BookCategory_Name { get; set; }
    }
}
