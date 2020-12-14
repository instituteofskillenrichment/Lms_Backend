using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.ViewComponents
{
    [ViewComponent(Name = "LibrarySidebar")]
    public class LibrarySidebarViewComponent : ViewComponent
    {
        private readonly ILibraryRepository _LibraryRepository;

        public LibrarySidebarViewComponent(ILibraryRepository LibraryRepository)
        {
            _LibraryRepository = LibraryRepository;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var Categories = _LibraryRepository.GetAllCategories();

            return View("LibrarySidebarVC", Categories);
        }
    }
}
