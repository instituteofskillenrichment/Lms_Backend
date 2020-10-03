using LMS.BusinessLogics.Interfaces;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace LMS.Controllers
{
    public class LoginController : Controller
    {
        private readonly UserManager<IdentityUser> userManager;
        private readonly SignInManager<IdentityUser> signInManager;
        private readonly ITeacherRepository teacherRepository;

        public LoginController(UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager, ITeacherRepository teacherRepository)
        {
            this.userManager = userManager;
            this.signInManager = signInManager;
            this.teacherRepository = teacherRepository;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Index(LoginViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var user = await userManager.FindByEmailAsync(model.Email);

                //if (user != null && 
                //                    (await userManager.CheckPasswordAsync(user, model.Password)))
                //{
                //    ModelState.AddModelError(string.Empty, "Email not confirmed yet");
                //    return View(model);
                //}

                var result = await signInManager.PasswordSignInAsync(user.UserName, model.Password,
                                        model.RememberMe, false);

                if (result.Succeeded)
                {
                    var roleDetails = await userManager.GetRolesAsync(user);

                    if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else if (roleDetails[0] == "Admin") //Admin case
                    {
                        return RedirectToAction("Index", "Dashboard", new { area = "Admin" });
                    }
                    else if (roleDetails[0] == "Teacher") //Teacher case
                    {
                        var teacherObj = teacherRepository.FindTeacherByRefId(user.Id);

                        HttpContext.Session.SetInt32("UserId", teacherObj.Teacher_Id);

                        return RedirectToAction("Index", "Home", new { area = "Teachers" });
                    }
                    else //Student case
                    {
                        return RedirectToAction("Index", "Home", new { area = "Students" });
                    }
                }

                if (result.IsLockedOut)
                {
                    //need to create
                    return View("AccountLocked");
                }

                ModelState.AddModelError(string.Empty, "Invalid Login Attempt");
            }

            return View(model);
        }
    }
}