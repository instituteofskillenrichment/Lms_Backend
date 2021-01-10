using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IUserRepository
    {
        IQueryable<AppUser> GetAllUserWithRoles();

        Task<int> CreateUser(IdentityUser objModel, string Password);

        Task<int> AssignToRole(IdentityUser objModel, string UserRole);

        IQueryable<AppUser> FindUserWithRoleById(string userId);

        Task<IdentityUser> FindUserById(string userId);
        Task<int> UpdateUser(IdentityUser objModel);

        //Added by Arib on 30-Aug-2020
        Task<IList<string>> GetRoles(IdentityUser objModel);

        //Added by Arib on 30-Aug-2020
        Task<IdentityResult> RemoveRole(IdentityUser objModel, string role);

        //Added by Arib on 30-Aug-2020
        Task<int> DeleteUser(IdentityUser objModel);

        Task<int> ResetPassword(IdentityUser objModel, string Password);

        //Added By Absar on 4-1-2021
        AppUser GetUserImage(string UserId, string Role);

    }
}
