using LMS.Domain;
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
        Task<Library> GetBookById(int Id);
        IQueryable<Library> GetAllBooksByCategoryId(int CategoryId);
        Task<int> AddBook(Library objLibrary);

        Library FindBookById(int Id);
        Task<int> SaveChanges();
    }
}
