using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using LMS.BusinessLogics.Interfaces;
using LMS.Common;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MimeKit;

namespace LMS.Controllers
{
    public class LibraryController : Controller
    {
        private readonly IUserRepository _UserRepository;
        private readonly ILibraryRepository _LibraryRepository;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IConfiguration _config;
        public LibraryController(ILibraryRepository LibraryRepository, IUserRepository UserRepository, IHostingEnvironment hostingEnvironment, IConfiguration config)
        {
            _LibraryRepository = LibraryRepository;
            _UserRepository = UserRepository;
            _hostingEnvironment = hostingEnvironment;
            _config = config;
        }

        public async Task<IActionResult> Index()
        {
            ViewBag.Categories = _LibraryRepository.GetAllCategories();

            var Books =  _LibraryRepository.GetAllBooks().ToList();

            return View(Books);
        }

        [HttpGet]
        [Route("addBook")]
        public IActionResult AddBook()
        {
            ViewBag.Categories = _LibraryRepository.GetAllCategories();

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
        [Route("addBook")]
        public async Task<IActionResult> AddBook(LibraryViewModel objLibrary)
        {
            if (ModelState.IsValid)
            {
                string uniqueFileName = Utility.ProcessUploadedFile(objLibrary.Book_File, _hostingEnvironment, "Library");

                Library newLibrary = new Library
                {
                    Book_Name = objLibrary.Book_Name,
                    Book_Detail = objLibrary.Book_Detail,
                    BookCategory_Id = objLibrary.BookCategory_id,
                    Book_File = uniqueFileName,


                };

                int Id = await _LibraryRepository.AddBook(newLibrary);

                UploadImage(Id);

                int result = await _LibraryRepository.SaveChanges();

                if (result == 1)
                {
                    TempData["Success"] = " Book Added Successfully";
                    return RedirectToAction("AddBook", "Library");

                }
                else
                {
                    TempData["Error"] = "Adding Book Failed";
                    return RedirectToAction("AddBook", "Library");
                    
                }

            }

            return View();

        }

        
        public void UploadImage(int id)
        {
            //login to save image path in db
            //get bike id we have saved in db

            //var BikeID = BikeVM.Bike.Id;

            var bookId = id;

            //gte root folder path on save image on server

            string wwwRootPath = _hostingEnvironment.WebRootPath;

            //get the upload file
            var image = HttpContext.Request.Form.Files;

            

            //get the referenc of blog image we have saved in db
            var SaveBook = _LibraryRepository.FindBookById(bookId);



            //upload hte image on server and save path on db

            if (image.Count != 0)
            {
                 
                if(image[0].ContentType == "image/jpg" || image[0].ContentType == "image/jpeg" || image[0].ContentType == "image/pjpeg" || image[0].ContentType == "image/gif" || image[0].ContentType == "image/x-png" || image[0].ContentType == "image/png")
                {
                    var imagePath = @"\Dashboard\assets\img\Book-Img\";
                    // var Extension = Path.GetExtension(files[0].FileName);
                    var FileName = Path.GetFileName(image[0].FileName);
                    var RelativeImagePath = imagePath + FileName;
                    //var AbsoluteImagePath = Path.Combine(wwwRootPath, RelativeImagePath);
                    var AbsoluteImagePath = wwwRootPath + RelativeImagePath;

                    //upload file on server
                    using (var fileStream = new FileStream(AbsoluteImagePath, FileMode.Create))
                    {
                        image[0].CopyTo(fileStream);
                    }

                    //save imagepath to db
                    SaveBook.Book_Image = RelativeImagePath;
                    //_TeacherRepository.SaveChanges();
                }
                else
                {
                    var imagePath = @"\Dashboard\assets\img\Book-Img\";
                    // var Extension = Path.GetExtension(files[0].FileName);
                    var FileName = "noPhotoFound.png";
                    var RelativeImagePath = imagePath + FileName;
                    //var AbsoluteImagePath = Path.Combine(wwwRootPath, RelativeImagePath);
                    var AbsoluteImagePath = wwwRootPath + RelativeImagePath;

                    //upload file on server
                    using (var fileStream = new FileStream(AbsoluteImagePath, FileMode.Create))
                    {
                        image[0].CopyTo(fileStream);
                    }

                    //save imagepath to db
                    SaveBook.Book_Image = RelativeImagePath;
                }

            }
        }

        
        [HttpGet]
        [Route("downloadBook")]
        public async Task<IActionResult> DownloadBook(int Id)
        {
            var BookFile = await _LibraryRepository.GetBookById(Id);

            //string fileName = lectureFile.Lecture_File.Split('_')[1];
            string fileName = BookFile.Book_File.Split('_')[1];

            //lectureFile.Lecture_File = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LectureFilesPath").Value + lectureFile.Lecture_File;
            BookFile.Book_File = _hostingEnvironment.WebRootPath + _config.GetSection("AppSettings").GetSection("LibraryFilesPath").Value + BookFile.Book_File;

            // return PhysicalFile(lectureFile.Lecture_File, MimeTypes.GetMimeType(lectureFile.Lecture_File), fileName);
            return PhysicalFile(BookFile.Book_File, MimeTypes.GetMimeType(BookFile.Book_File), fileName);
        }


        [Route("category")]
        public IActionResult Category(int CategoryId)
        {

            ViewBag.Categories = _LibraryRepository.GetAllCategories();

            var category = _LibraryRepository.GetAllBooksByCategoryId(CategoryId).ToList();

            
            return View("Index", category);
        }



        [Route("search")]
        public IActionResult Search(int BookCategory_Id, string Book_Name)
        {

            ViewBag.Categories = _LibraryRepository.GetAllCategories();

            var search = _LibraryRepository.SearchBooks(BookCategory_Id, Book_Name).ToList();


            return View("Index", search);
        }


    }
}