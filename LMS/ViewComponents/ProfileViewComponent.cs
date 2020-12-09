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

namespace LMS.ViewComponents
{
    [ViewComponent(Name = "Profile")]
    public class ProfileViewComponent : ViewComponent
    {
        private LmsDbContext _lmsDbContext;
        private readonly IUserRepository _UserRepository;
        private readonly UserManager<IdentityUser> userManager;
        private readonly SignInManager<IdentityUser> signInManager;

        public ProfileViewComponent(LmsDbContext lmsDbContext, IUserRepository UserRepository)
        {
            _lmsDbContext = lmsDbContext;
            _UserRepository = UserRepository;
        }


        public async Task<IViewComponentResult> InvokeAsync()
        {
            return View("ProfileVC");
        }
    }
}
