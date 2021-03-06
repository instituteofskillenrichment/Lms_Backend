﻿using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ILibraryRepository
    {
        IQueryable<BookCategory> GetAllCategories();
        IQueryable<Library> GetAllBooks();
        IQueryable<Library> GetAllRecentBooks();
        Task<Library> GetBookById(int Id);
        IQueryable<Library> GetAllBooksByCategoryId(int CategoryId);

        IQueryable<Library> SearchBooks(int CategoryId, string Name);

        Task<int> AddBook(Library objLibrary);

        Library FindBookById(int Id);
        Task<int> SaveChanges();
    }
}
