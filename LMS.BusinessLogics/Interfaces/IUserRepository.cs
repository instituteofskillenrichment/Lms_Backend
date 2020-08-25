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
        Task<int> CreateUser(IdentityUser objModel, string User_Role);
        Task<int> UpdateUser(IdentityUser objModel);
        Task<int> DeleteUser(string userId);
        IQueryable GetAllUser();
        Task<IdentityUser> FindUserById(string userId);
        
    }
}
