using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class LibraryViewModel
    {
        public string Book_Name { get; set; }
        public string Book_Detail { get; set; }
        public IFormFile Book_File { get; set; }
        public string Book_Image { get; set; }
        public int BookCategory_id { get; set; }


        
    }
}
