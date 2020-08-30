using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class UserViewModel
    {
        public int User_Id { get; set; }
        public string User_Name { get; set; }
        public string User_Email { get; set; }
        public int User_Password { get; set; }
    }
}
