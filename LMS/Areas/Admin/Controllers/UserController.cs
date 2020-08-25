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


            var User = _UserRepository.GetAllUser();

            

            ViewBag.User = User;
            //ViewBag.Role = _RoleRepository.GetAllRoles();
            ////var AppUserVM = new AppUser();
            //var User = _UserRepository.GetAllUser();


            return View();
        }



        [HttpPost]
        [Route("addUser")]
        public async Task<IActionResult> AddUser(string UserName, string Email,string PasswordHash, string User_Role)
        {
            if (ModelState.IsValid)
            {


                IdentityUser User = new IdentityUser
                {
                    

                    UserName = UserName,
                    Email = Email,
                    PasswordHash = PasswordHash
                    
                };

                await _UserRepository.CreateUser(User, User_Role);

                return RedirectToAction("Index", "user", new { area = "admin" });

            }

            return View();
        }


        [HttpPost]
        [Route("deleteUser")]
        public async Task<IActionResult> DeleteUser(string User_Id)
        {

            if (!string.IsNullOrEmpty(User_Id))
            {
                await _UserRepository.DeleteUser(User_Id);

                return RedirectToAction("Index", "user", new { area = "admin" });
            }

            return View();
        }


        [HttpGet]
        [Route("editUser/{User_Id}")]
        public async Task<IActionResult> EditUser(string User_Id)
        {


            ViewBag.Role = _RoleRepository.GetAllRoles();

            var objUser = await _UserRepository.FindUserById(User_Id);

            return new JsonResult(objUser);

        }


        [HttpPost]
        [Route("editUser")]
        public async Task<IActionResult> EditUser(string User_Id, string User_Name, string User_Email, string User_Password)
        {
            if (ModelState.IsValid)
            {
                IdentityUser UserModel = await _UserRepository.FindUserById(User_Id);

                UserModel.UserName = User_Name;
                UserModel.Email = User_Email;
                UserModel.PasswordHash = User_Password;

                await _UserRepository.UpdateUser(UserModel);

                return RedirectToAction("Index", "user", new { area = "admin" });

            }

            return View();
        }



    }
}