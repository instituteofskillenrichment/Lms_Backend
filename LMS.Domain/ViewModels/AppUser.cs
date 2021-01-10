using Microsoft.AspNetCore.Identity;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class AppUser 
    {

        public string UserId { get; set; }
        public string UserName { get; set; }
        public string UserEmail { get; set; }
        public string UserPassword{ get; set; }
        public string UserRoleId { get; set; }
        public string UserRole { get; set; }
        public string UserImage { get; set; }

        //public IdentityUser User { get; set; }

        //public List<SelectListItem> Role { get; set; }

    }
}
