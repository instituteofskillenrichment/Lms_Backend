using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace LMS.Controllers
{
    public class LoginController : Controller
    {
        private readonly UserManager<IdentityUser> userManager;
        private readonly SignInManager<IdentityUser> signInManager;
        private readonly ITeacherRepository teacherRepository;
        private readonly IStudentRepository studentRepository;
        private readonly IUserRepository _UserRepository;


        public LoginController(UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager, ITeacherRepository teacherRepository, IStudentRepository studentRepository, IUserRepository UserRepository)
        {
            this.userManager = userManager;
            this.signInManager = signInManager;
            this.teacherRepository = teacherRepository;
            this.studentRepository = studentRepository;
            _UserRepository = UserRepository;

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
                var user = await userManager.FindByNameAsync(model.UserName);

               
                var result = await signInManager.PasswordSignInAsync(user.UserName, model.Password,model.RememberMe, lockoutOnFailure: true);

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

                        return RedirectToAction("Index", "Dashboard", new { area = "Teachers" });
                    }
                    else //Student case
                    {
                        var studentObj = studentRepository.FindStudentByRefId(user.Id);
                        HttpContext.Session.SetInt32("UserId", studentObj.Student_Id);

                        return RedirectToAction("Index", "Dashboard", new { area = "Students" });
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



        //[HttpPost]
        [Route("logOut")]
        public async Task<IActionResult> LogOut()
        {
            if(ModelState.IsValid)
            {
                await signInManager.SignOutAsync();

                return RedirectToAction("Index", "Login");
            }

            return View();
        }


        [HttpGet]
        [Route("profile")]
        public async Task<IActionResult> Profile()
        {
            string UserId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            

            var user = await _UserRepository.FindUserById(UserId);

            if(user != null)
            {
                var roles = await _UserRepository.GetRoles(user);
                roles = roles.Select(x => x.ToUpper()).ToList();

                if (roles != null)
                {
                    if (roles[0] == "ADMIN")
                    {
                        ViewBag.Layout = "~/Areas/Admin/Views/Shared/_AdminLayout.cshtml";
                        return View(user);
                        
                    }
                    else if (roles[0] == "TEACHER")
                    {
                        ViewBag.Layout = "~/Areas/Teachers/Views/Shared/_TeacherLayout.cshtml";
                        return View(user);
                    }
                    else if (roles[0] == "STUDENT")
                    {
                        
                         ViewBag.Layout = "~/Areas/Students/Views/Shared/_Studentayout.cshtml";
                        return View(user);
                    }
                }
            }


            return View();
        }


        [HttpPost]
        [Route("profile")]
        public async Task<IActionResult> Profile(IdentityUser mdlUser)
        {


            if (ModelState.IsValid)
            {

                IdentityUser UserModel = await _UserRepository.FindUserById(mdlUser.Id);

                if (UserModel != null)
                {
                    int result = 0;
                    var roles = await _UserRepository.GetRoles(UserModel);
                    roles = roles.Select(x => x.ToUpper()).ToList();

                    if (roles != null)
                    {
                        if (roles[0] == "ADMIN")
                        {
                            result = await _UserRepository.ResetPassword(UserModel, mdlUser.PasswordHash);
                            TempData["Success"] = "User Password Update Successfully...";
                            ViewBag.Success = TempData["Success"].ToString();
                            ViewBag.Layout = "~/Areas/Admin/Views/Shared/_AdminLayout.cshtml";
                            return View(UserModel);

                        }
                        else if (roles[0] == "TEACHER")
                        {
                            result = await _UserRepository.ResetPassword(UserModel, mdlUser.PasswordHash);
                            TempData["Success"] = "User Password Update Successfully...";
                            ViewBag.Success = TempData["Success"].ToString();
                            ViewBag.Layout = "~/Areas/Teachers/Views/Shared/_TeacherLayout.cshtml";
                            return View(UserModel);
                        }
                        else if (roles[0] == "STUDENT")
                        {
                            result = await _UserRepository.ResetPassword(UserModel, "Student@123");
                        }


                        if (result == 1)
                        {
                            TempData["Success"] = "User Password Update Successfully...";

                            

                            if (TempData["Success"] != null)
                            {
                                ViewBag.Success = TempData["Success"].ToString();
                            }

                            return View(UserModel);
                        }
                        else
                        {
                            TempData["Error"] = "User Password Update Failed...";

                            if (TempData["Error"] != null)
                            {
                                ViewBag.Error = TempData["Error"].ToString();
                            }
                            
                            return View();
                        }



                    }
                    else
                    {
                        TempData["Error"] = "UserRole Not Found. Please try again!";
                        ViewBag.Error = TempData["Error"].ToString();
                        return View();
                    }
                }
                else
                {
                    TempData["Error"] = "User Not Found. Please try again!";
                    ViewBag.Error = TempData["Error"].ToString();
                    return View(); 
                }

            }

            return View();

        }





    }
}