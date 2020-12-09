using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class RoleRepository : IRoleRepository
    {
        
        private RoleManager<IdentityRole> _roleManager;

        public RoleRepository(RoleManager<IdentityRole> roleManager)
        {
            
            _roleManager = roleManager;

        }

        public async Task<int> CreateRole(IdentityRole objModel)
        {
            try
            {
                bool checkRole = await IsRoleExist(objModel.Name);


                if (checkRole == false)
                {
                    IdentityResult result = await _roleManager.CreateAsync(new IdentityRole(objModel.Name));
                    if (result.Succeeded)
                    {
                        return 1;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }

            }
            catch(Exception)
            {
                return -1;
            }

            
        }

        public async Task<int> DeleteRole(string roleId)
        {

            try
            {
                IdentityRole role = await FindRoleById(roleId);

                //IdentityRole role = await _roleManager.FindByIdAsync(roleId);

                if (role != null)
                {
                    IdentityResult result = await _roleManager.DeleteAsync(role);
                    if (result.Succeeded)
                        return 1;
                    else
                        return 0;
                }
                else
                {
                    return 0;
                }

                
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public async Task<IdentityRole> FindRoleById(string roleId)
        {
            IdentityRole Roles = await _roleManager.FindByIdAsync(roleId);
            
            return Roles;
        }

        public async Task<IdentityRole> FindRoleByName(string roleName)
        {
            IdentityRole Roles = await _roleManager.FindByNameAsync(roleName);

            return Roles;
        }

        public IQueryable<IdentityRole> GetAllRoles()
        {
            IQueryable<IdentityRole> identityRole = _roleManager.Roles;

            return identityRole;
        }

        public async Task<bool> IsRoleExist(string roleName)
        {
            bool  findRoles = await _roleManager.RoleExistsAsync(roleName);

            return findRoles;
        }

        public async Task<int> UpdateRole(IdentityRole objModel)
        {

            try
            {
                IdentityResult result = await _roleManager.UpdateAsync(objModel);

                if (result.Succeeded)
                    return 1;
                else
                    return 0;
            }
            catch(Exception ex)
            {
                return -1;
            }

        }


    }
}
