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

        Task<int> CreateUser(IdentityUser objModel);

        Task<int> AssignToRole(IdentityUser objModel, string UserRole);

        IQueryable<AppUser> FindUserWithRoleById(string userId);

        Task<IdentityUser> FindUserById(string userId);
        //Task<int> UpdateUser(IdentityUser objModel);
        //Task<int> DeleteUser(string userId);



    }
}
