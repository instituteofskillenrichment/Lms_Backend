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

        public UserRepository(UserManager<IdentityUser> userManager, LmsDbContext lmsDbContext, IRoleRepository RoleRepository)
        {
            _userManager = userManager;
            _lmsDbContext = lmsDbContext;
            _RoleRepository = RoleRepository;
        }

        public async Task<int> CreateUser(IdentityUser objModel, string User_Role)
        {
            if (objModel != null)
            {
                IdentityResult result = await _userManager.CreateAsync(objModel);

                if (result.Succeeded)
                {
                    IdentityRole RoleModel = await _RoleRepository.FindRoleById(User_Role);

                    if (RoleModel != null)
                    {
                        IdentityResult success = await _userManager.AddToRoleAsync(objModel, RoleModel.Name);

                        if (success.Succeeded)
                        {
                            return 1;
                        }
                        else
                        {
                            return 0;
                        }
                    }
                    
                }
                else
                {
                    return 0;
                }
            }

            return -1;
        }

        public async Task<int> DeleteUser(string userId)
        {
            IdentityUser user = await FindUserById(userId);

            if (user != null)
            {
                IdentityResult result = await _userManager.DeleteAsync(user);
                if (result.Succeeded)
                    return 1;
                else
                    return 0;
            }

            return -1;
        }

        public async Task<IdentityUser> FindUserById(string userId)
        {

            IdentityUser findUser = await _userManager.FindByIdAsync(userId);

            return findUser;
        }

        

        public IQueryable<AppUser> GetAllUser()
        {

            IQueryable<AppUser> user = from u in _lmsDbContext.Users
                       join ur in _lmsDbContext.UserRoles on u.Id equals ur.UserId
                       join r in _lmsDbContext.Roles on ur.RoleId equals r.Id
                       select new AppUser
                       {
                          UserId =  u.Id,
                          UserName = u.UserName,
                          UserEmail =  u.Email,
                          UserPassword =  u.PasswordHash,
                          UserRole= r.Name
                       };


            
            //var list = new List<string>();

                       //foreach (var user in _userManager.Users.ToList())
                       //{
                       //    list.Add(new
                       //    {
                       //        //Id = user.Id,
                       //        user.Id,
                       //        //UserName = user.UserName,
                       //        user.UserName,
                       //        //Email = user.Email,
                       //        user.Email,
                       //        //PasswordHash = user.PasswordHash,
                       //        user.PasswordHash,
                       //        Roles = ( _userManager.GetRolesAsync(user))
                       //    });
                       //}


                       //IQueryable<IdentityUser> identityUser =  _userManager.Users;

            return user;
        }

        public async Task<int> UpdateUser(IdentityUser objModel)
        {
            IdentityResult result = await _userManager.UpdateAsync(objModel);

            if (result.Succeeded)
                return 1;
            else
                return 0;
        }
    }
}
