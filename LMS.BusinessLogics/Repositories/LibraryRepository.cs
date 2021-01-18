using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class LibraryRepository : ILibraryRepository
    {
        private LmsDbContext _lmsDbContext;

        public LibraryRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddBook(Library objLibrary)
        {

            try
            {
                await _lmsDbContext.Library.AddAsync(objLibrary);

                int bookId = objLibrary.Book_Id;

                return bookId;
            }
            catch (Exception ex)
            {
                //_logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;
            }

        }

        public Library FindBookById(int Id)
        {
            Library Book = _lmsDbContext.Library.Find(Id);


            return Book;
        }

        public IQueryable<Library> GetAllBooks()
        {
            IQueryable<Library> listOfBooks = _lmsDbContext.Library.AsQueryable();

            return listOfBooks;
        }

        public IQueryable<Library> GetAllBooksByCategoryId(int CategoryId)
        {
            var listOfBook = _lmsDbContext.Library
                        .AsNoTracking()
                        .Where(b => b.BookCategory_Id == CategoryId);

            return listOfBook;
        }

        public IQueryable<BookCategory> GetAllCategories()
        {
            IQueryable<BookCategory> listOfCategories =  _lmsDbContext.BookCategory.AsQueryable();

            return listOfCategories;
        }

        public async Task<Library> GetBookById(int Id)
        {
            var Book = await _lmsDbContext.Library
                        .AsNoTracking()
                        .FirstOrDefaultAsync(b => b.Book_Id == Id);

            return Book;
        }

        public async Task<int> SaveChanges()
        {
            try
            {
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<Library> SearchBooks(int CategoryId, string Name)
        {
            var listOfBook = _lmsDbContext.Library
                        .AsNoTracking()
                        .Where(b => b.BookCategory_Id == CategoryId || b.Book_Name.Contains(Name) );

            return listOfBook;
        }
    }
}
