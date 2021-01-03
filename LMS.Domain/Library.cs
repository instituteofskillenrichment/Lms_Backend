using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class Library
    {
        [Key]
        public int Book_Id { get; set; }
        public string Book_Name { get; set; }
        public string Book_Detail { get; set; }
        public string Book_File { get; set; }
        public string Book_Image { get; set; }
        

        public BookCategory BookCategory { get; set; }
        public int BookCategory_Id { get; set; }
    }
}
