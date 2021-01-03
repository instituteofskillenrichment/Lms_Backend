using LMS.BusinessLogics.Interfaces;
using LMS.Domain;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace LMS.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    [Area("admin")]
    [Route("admin/class")]
    public class ClassController : Controller
    {
        private readonly IClassRepository _ClassRepository;

        public ClassController(IClassRepository ClassRepository)
        {
            _ClassRepository = ClassRepository;
        }


        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            var Class = _ClassRepository.GetAllClass();

            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"].ToString();
            }

            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"].ToString();
            }

            return View(Class);
        }


        [HttpPost]
        [Route("addClass")]
        public async Task<IActionResult> AddClass(Class objClass)
        {
            if (ModelState.IsValid)
            {
                Class newClass = new Class
                {
                    Class_Name = objClass.Class_Name.ToUpper()
                };

                int result =  await _ClassRepository.AddClass(newClass);
                if(result == 1)
                {
                    TempData["Success"] = " Class Added Successfully"; 
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Adding Class Failed";
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }

                

            }

            return View();
        }


        [HttpPost]
        [Route("deleteClass")]
        public async Task<IActionResult> DeleteClass(int Class_Id)
        {
            if (ModelState.IsValid)
            {
               int result = await _ClassRepository.DeleteClass(Class_Id);

                if (result == 1)
                {
                    TempData["Success"] = "Delete Class Successfully";
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Deleting Class Failed";
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }
            }

            return View();

        }



        [HttpGet]
        [Route("editClass/{id}")]
        public async Task<IActionResult> EditClass(int id)
        {
            var objClass =  await _ClassRepository.GetClassById(id);

            return new JsonResult(objClass);

        }



        [HttpPost]
        [Route("editClass")]
        public async Task<IActionResult> EditClass(Class classModel)
        {
            if (ModelState.IsValid)
            {
                Class objClass = await _ClassRepository.GetClassById(classModel.Class_Id);

                objClass.Class_Name = classModel.Class_Name.ToUpper();

                int result = await _ClassRepository.UpdateClass(objClass);

                if (result == 1)
                {
                    TempData["Success"] = "Class Updated Successfully";
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }
                else
                {
                    TempData["Error"] = "Updating Class Failed ";
                    return RedirectToAction("Index", "class", new { area = "admin" });
                }

            }

            return View();
        }


    }
}