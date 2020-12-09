using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
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
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

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

                int result = await _RoleRepository.CreateRole(RoleModel);

                if(result == 1)
                {
                    TempData["Success"] = "Role Added Succesfully";
                    return RedirectToAction("Index", "role", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Role Added Failed";
                    return RedirectToAction("Index", "role", new { area = "admin" });
                }

                

            }

            return View();
        }



        [HttpPost]
        [Route("deleteRole")]
        public async Task<IActionResult> DeleteRole(string Role_Id)
        {

            if(ModelState.IsValid)
            {
                if (!string.IsNullOrEmpty(Role_Id))
                {
                    int result = await _RoleRepository.DeleteRole(Role_Id);
                    
                    if (result == 1)
                    {
                        TempData["Success"] = "Role Deleted Succesfully";
                        return RedirectToAction("Index", "role", new { area = "admin" });
                    }
                    else
                    {
                        TempData["Error"] = "Deleting Role Failed";
                        return RedirectToAction("Index", "role", new { area = "admin" });
                    }
                }
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

                if(RoleModel != null)
                {
                    RoleModel.Name = Role_Name;

                    int result = await _RoleRepository.UpdateRole(RoleModel);

                    if (result == 1)
                    {
                        TempData["Success"] = "Role Updated Succesfully";
                        return RedirectToAction("Index", "role", new { area = "admin" });
                    }
                    else
                    {
                        TempData["Error"] = "Updating Role Failed";
                        return RedirectToAction("Index", "role", new { area = "admin" });
                    }
                }
                else
                {
                    TempData["Error"] = "Rolle Didn't Find";
                    return RedirectToAction("Index", "role", new { area = "admin" });
                }

               

            }

            return View();
        }


    }
}