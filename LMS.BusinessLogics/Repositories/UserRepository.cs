using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;

using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class UserRepository : IUserRepository
    {
        private UserManager<IdentityUser> _userManager;
        private readonly IRoleRepository _RoleRepository;
        private LmsDbContext _lmsDbContext;

        public object ModelState { get; private set; }

        public UserRepository(UserManager<IdentityUser> userManager, LmsDbContext lmsDbContext, IRoleRepository RoleRepository)
        {
            _userManager = userManager;
            _lmsDbContext = lmsDbContext;
            _RoleRepository = RoleRepository;
        }

        public IQueryable<AppUser> GetAllUserWithRoles()
        {

            IQueryable<AppUser> user = from u in _lmsDbContext.Users
                                       join ur in _lmsDbContext.UserRoles on u.Id equals ur.UserId
                                       join r in _lmsDbContext.Roles on ur.RoleId equals r.Id
                                       select new AppUser
                                       {
                                           UserId = u.Id,
                                           UserName = u.UserName,
                                           UserEmail = u.Email,
                                           UserPassword = u.PasswordHash,
                                           UserRole = r.Name
                                       };

            return user;
        }

        public async Task<int> CreateUser(IdentityUser objModel, string Password)
        {
            if (objModel != null)
            {
                IdentityResult result = await _userManager.CreateAsync(objModel, Password);

                if (result.Succeeded)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }

            return -1;
        }

        public async Task<int> AssignToRole(IdentityUser objModel, string UserRole)
        {
            
            IdentityRole getRole = await _RoleRepository.FindRoleById(UserRole);

            IdentityResult result;

            if(getRole == null)
            {
                getRole = await _RoleRepository.FindRoleByName(UserRole);

                if(getRole == null)
                {
                    return -1;
                }

                result = await _userManager.AddToRoleAsync(objModel, getRole.Name);
            }
            else
            {
                result = await _userManager.AddToRoleAsync(objModel, getRole.Name);
            }


            if (result.Succeeded)
            {
                return 1;
            }
            else
            {
                return 0;
            }

            ////By Using Role_Id
            //IdentityRole getRoleId = await _RoleRepository.FindRoleById(UserRole);

            //if (getRoleId != null)
            //{
            //   IdentityResult result = await _userManager.AddToRoleAsync(objModel, getRoleId.Name);

            //    if (result.Succeeded)
            //    {
            //        return 1;
            //    }
            //    else
            //    {
            //        return 0;
            //    }
            //}


            ////By Using Role_Name
            //IdentityRole getRoleName = await _RoleRepository.FinRoleByName(UserRole);

            //if (getRoleName != null)
            //{
            //    IdentityResult result = await _userManager.AddToRoleAsync(objModel, getRoleName.Name);

            //    if (result.Succeeded)
            //    {
            //        return 1;
            //    }
            //    else
            //    {
            //        return 0;
            //    }

            //}


            //return -1;
        }

        public async Task<int> AssignToRoleV2(IdentityUser objModel, string UserRole)
        {
            IdentityRole getRole = await _RoleRepository.FindRoleById(UserRole);

            IdentityResult result;

            if (getRole == null)
            {
                getRole = await _RoleRepository.FindRoleByName(UserRole);

                if (getRole == null)
                {
                    return -1;
                }

                result = await _userManager.AddToRoleAsync(objModel, getRole.Name);
            }
            else
            {
                result = await _userManager.AddToRoleAsync(objModel, getRole.Name);
            }

            return result.Succeeded ? 1 : 0;

        }


        public IQueryable<AppUser> FindUserWithRoleById(string userId)
        {



            var findUser = (from u in _lmsDbContext.Users
                            join ur in _lmsDbContext.UserRoles on u.Id equals ur.UserId
                            join r in _lmsDbContext.Roles on ur.RoleId equals r.Id
                            where u.Id == userId
                            select new AppUser
                            {
                                UserId = u.Id,
                                UserName = u.UserName,
                                UserEmail = u.Email,
                                UserPassword = u.PasswordHash,
                                UserRoleId = r.Id,
                                UserRole = r.Name
                            });







            return findUser;
        }

        public Task<IdentityUser> FindUserById(string userId)
        {
            var user = _userManager.FindByIdAsync(userId);

            return user;
        }


        public async Task<int> DeleteUser(IdentityUser objModel)
        {
            var result = await _userManager.DeleteAsync(objModel);

            if (result.Succeeded)
                return 1;
            else
                return 0;
        }

        //public IQueryable<AppUser> FindUserById(string userId)
        //{

        //    //IdentityUser findUser = await _userManager.FindByIdAsync(userId);

        //    var findUser = (from u in _lmsDbContext.Users
        //                   join ur in _lmsDbContext.UserRoles on u.Id equals ur.UserId
        //                   join r in _lmsDbContext.Roles on ur.RoleId equals r.Id
        //                   where u.Id == userId
        //                   select new AppUser
        //                   {
        //                       UserId = u.Id,
        //                       UserName = u.UserName,
        //                       UserEmail = u.Email,
        //                       UserPassword = u.PasswordHash,
        //                       UserRole = r.Name
        //                   });





        //    //var findUser = _lmsDbContext.UserRoles.AsNoTracking().FirstOrDefaultAsync(e => e.UserId == userId);

        //    return findUser;
        //}

        public async Task<int> UpdateUser(IdentityUser objModel)
        {
            IdentityResult result = await _userManager.UpdateAsync(objModel);

            if (result.Succeeded)
                return 1;
            else
                return 0;
        }

        //Added by Arib on 30-Aug-2020
        public async Task<IList<string>> GetRoles(IdentityUser objModel)
        {
            var roles = await _userManager.GetRolesAsync(objModel);

            return roles;
        }

        //Added by Arib on 30-Aug-2020
        public async Task<IdentityResult> RemoveRole(IdentityUser objModel, string role)
        {
            var result = await _userManager.RemoveFromRoleAsync(objModel, role);

            return result;

        }



        public async Task<int> ResetPassword(IdentityUser objModel, string Password)
        {
            if (objModel != null)
            {

                await _userManager.RemovePasswordAsync(objModel);

                IdentityResult result = await _userManager.AddPasswordAsync(objModel, Password);

                //IdentityResult result = await _userManager.ChangePasswordAsync(objModel.Id, objModel.PasswordHash, Password);

                

                if (result.Succeeded)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }

            return -1;
        }

    }
}
