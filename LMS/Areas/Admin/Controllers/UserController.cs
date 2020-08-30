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
            
            ////var AppUserVM = new AppUser();
            //var User = _UserRepository.GetAllUser();


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

                if(userSucceed ==1)
                {
                    //int assignRole = await _UserRepository.AssignToRole(User, objAppUser.UserRole);

                    await _UserRepository.AssignToRole(User, objAppUser.UserRole);

                }
                else
                {
                    //foreach (IdentityError error in userSucceed.Errors)
                    //    ModelState.AddModelError("", error.Description);
                }

                return RedirectToAction("Index", "user", new { area = "admin" });

            }
            

            return View();
        }


        //[HttpPost]
        //[Route("deleteUser")]
        //public async Task<IActionResult> DeleteUser(string User_Id)
        //{

        //    if (!string.IsNullOrEmpty(User_Id))
        //    {
        //        await _UserRepository.DeleteUser(User_Id);

        //        return RedirectToAction("Index", "user", new { area = "admin" });
        //    }

        //    return View();
        //}


        [HttpGet]
        [Route("editUser/{User_Id}")]
        public IActionResult EditUser(string User_Id)
        {


            ViewBag.Role = _RoleRepository.GetAllRoles();

            var objUserWithRole =  _UserRepository.FindUserWithRoleById(User_Id);

            //if(objUserWithRole != null)
            //{
            //    var objUser = _UserRepository.FindUserById(User_Id);
            //    return new JsonResult(objUser);
            //}


            return new JsonResult(objUserWithRole);

        }


        //[HttpPost]
        //[Route("editUser")]
        //public async Task<IActionResult> EditUser(string User_Id, string User_Name, string User_Email, string User_Password, string User_Role)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        //IdentityUser UserModel = await _UserRepository.FindUserById(User_Id);

        //        var UserModel =  _UserRepository.FindUserById(User_Id);

        //        //IdentityUser identityUser = new IdentityUser
        //        //{
        //        //    Id = UserModel.UserId,
        //        //    UserName = UserModel.UserName,
        //        //    Email = UserModel.UserEmail,
        //        //    PasswordHash = UserModel.UserPassword
        //        //};

        //        //UserModel.UserName = User_Name;
        //        //UserModel.Email = User_Email;
        //        //UserModel.PasswordHash = User_Password;

        //        //await _UserRepository.UpdateUser(identityUser);

        //        return RedirectToAction("Index", "user", new { area = "admin" });

        //    }

        //    return View();
        //}



    }
}