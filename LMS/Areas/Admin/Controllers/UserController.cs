using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/user")]
    public class UserController : Controller
    {
        private readonly IUserRepository _UserRepository;
        private readonly IRoleRepository _RoleRepository;
        private LmsDbContext _lmsDbContext;

        public UserController(IUserRepository UserRepository, IRoleRepository RoleRepository, LmsDbContext lmsDbContext)
        {
            _UserRepository = UserRepository;
            _RoleRepository = RoleRepository;
            _lmsDbContext = lmsDbContext;
        }

        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var UserWithRole = _UserRepository.GetAllUserWithRoles();

            ViewBag.User = UserWithRole;

            ViewBag.Role = _RoleRepository.GetAllRoles();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View();
        }


        [HttpPost]
        [Route("addUser")]
        public async Task<IActionResult> AddUser(AppUser objAppUser)
        {
            if (ModelState.IsValid)
            {
                IdentityUser User = new IdentityUser
                {
                    UserName = objAppUser.UserName,
                    Email = objAppUser.UserEmail,
                    PasswordHash = objAppUser.UserPassword
                };

                int userSucceed = await _UserRepository.CreateUser(User);

                if (userSucceed == 1)
                {
                    var response  = await _UserRepository.AssignToRole(User, objAppUser.UserRole);

                    if (response != 1)
                    {
                        TempData["Error"] = "Failed to assign role to the user. Please try again!";
                        return RedirectToAction("Index", "user", new { area = "admin" });
                    }
                }
                else
                {
                    TempData["Error"] = "Failed to add user. Please try again!";
                    return RedirectToAction("Index", "user", new { area = "admin" });
                }

                TempData["Success"] = "User successfully added.";
                return RedirectToAction("Index", "user", new { area = "admin" });
            }

            return View();
        }


        [HttpPost]
        [Route("deleteUser")]
        public async Task<IActionResult> DeleteUser(string User_Id)
        {
            var user = await _UserRepository.FindUserById(User_Id);

            if (user == null)
            {
                TempData["Error"] = $"User with Id = {User_Id} cannot be found";
                return RedirectToAction("Index", "user", new { area = "admin" });
            }
            else
            {
                var result = await _UserRepository.DeleteUser(user);

                if (result != 1)
                {
                    TempData["Error"] = "Failed to delete user. Please try again!";
                    return RedirectToAction("Index", "user", new { area = "admin" });
                }

                TempData["Success"] = "User successfully deleted.";
                return RedirectToAction("Index", "user", new { area = "admin" });
            }
        }


        [HttpGet]
        [Route("editUser/{User_Id}")]
        public IActionResult EditUser(string User_Id)
        {
            ViewBag.Role = _RoleRepository.GetAllRoles();

            var objUserWithRole = _UserRepository.FindUserWithRoleById(User_Id);

            return new JsonResult(objUserWithRole);

        }


        [HttpPost]
        [Route("editUser")]
        public async Task<IActionResult> EditUser(string User_Id, string User_Name, string User_Email, string User_Password, string User_Role)
        {
            if (ModelState.IsValid)
            {
                IdentityUser UserModel = await _UserRepository.FindUserById(User_Id);

                UserModel.UserName = User_Name;
                UserModel.Email = User_Email;
                UserModel.PasswordHash = User_Password;

                int response = await _UserRepository.UpdateUser(UserModel);

                if (response == 1)
                {
                   var roles = await _UserRepository.GetRoles(UserModel);
                   var result = await _UserRepository.RemoveRole(UserModel, roles[0]);

                    if (!result.Succeeded)
                    {
                        TempData["Error"] = "Cannot remove user existing roles. Please try again!";
                        return RedirectToAction("Index", "user", new { area = "admin" });
                    }

                   response = await _UserRepository.AssignToRole(UserModel, User_Role);

                    if (response != 1)
                    {
                        TempData["Error"] = "Failed to update role to the user. Please try again!";
                        return RedirectToAction("Index", "user", new { area = "admin" });
                    }
                }
                else
                {
                    TempData["Error"] = "Failed to update user. Please try again!";
                    return RedirectToAction("Index", "user", new { area = "admin" });
                }

                TempData["Success"] = "User successfully updated.";
                return RedirectToAction("Index", "user", new { area = "admin" });
            }

            return View();
        }
    }
}