using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IRoleRepository 
    {


        Task<int> CreateRole(IdentityRole objModel);
        Task<int> UpdateRole(IdentityRole objModel);
        Task<int> DeleteRole(string roleId);
        Task<bool> IsRoleExist(string roleName);
        Task<IdentityRole> FindRoleById(string roleId);
        Task<IdentityRole> FindRoleByName(string roleName);
        IQueryable<IdentityRole> GetAllRoles();


    }
}
