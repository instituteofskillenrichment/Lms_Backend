using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin/role")]
    public class RoleController : Controller
    {
        private readonly IRoleRepository _RoleRepository;

        public RoleController(IRoleRepository RoleRepository)
        {
            _RoleRepository = RoleRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            //var Role = _RoleRepository.GetAllRoles();

            return View(_RoleRepository.GetAllRoles());
        }




        [HttpPost]
        [Route("addRole")]
        public async Task<IActionResult> AddRole(IdentityRole objIdentityRole)
        {
            if (ModelState.IsValid)
            {
                IdentityRole RoleModel = new IdentityRole
                {
                    Name = objIdentityRole.Name
                };

                await _RoleRepository.CreateRole(RoleModel);

                return RedirectToAction("Index", "role", new { area = "admin" });

            }

            return View();
        }



        [HttpPost]
        [Route("deleteRole")]
        public async Task<IActionResult> DeleteRole(string Role_Id)
        {

            if (!string.IsNullOrEmpty(Role_Id))
            {
                await _RoleRepository.DeleteRole(Role_Id);

                return RedirectToAction("Index", "role", new { area = "admin" });
            }
            
            return View();
        }



        [HttpGet]
        [Route("editRole/{Role_Id}")]
        public async Task<IActionResult> EditRole(string Role_Id)
        {
            var objRole = await _RoleRepository.FindRoleById(Role_Id);

            return new JsonResult(objRole);

        }




        [HttpPost]
        [Route("editRole")]
        public async Task<IActionResult> EditRole(string Role_Id, string Role_Name)
        {
            if (ModelState.IsValid)
            {
                IdentityRole RoleModel = await _RoleRepository.FindRoleById(Role_Id);

                RoleModel.Name = Role_Name;

                await _RoleRepository.UpdateRole(RoleModel);

                return RedirectToAction("Index", "role", new { area = "admin" });

            }

            return View();
        }


    }
}