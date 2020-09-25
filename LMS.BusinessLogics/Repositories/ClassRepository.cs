using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class ClassRepository : IClassRepository
    {
        private LmsDbContext _lmsDbContext;
        //private ILogger _logger;

        public ClassRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
            //_logger = logger;
        }

        public async Task<int> AddClass(Class objClass)
        {
            try
            {
                await _lmsDbContext.Class.AddAsync(objClass);
                await _lmsDbContext.SaveChangesAsync();

                return 1;

            }
            catch (Exception ex)
            {
               // _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;

            }
        }
        
        
        public async Task<int> DeleteClass(int id)
        {
           try
            {
                var deleteClass = await GetClassById(id);

                _lmsDbContext.Class.Remove(deleteClass);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public IQueryable<Class> GetAllClass()
        {
            IQueryable<Class> listOfClass = _lmsDbContext.Class.AsQueryable();

            return listOfClass;
        }

        public async Task<Class> GetClassById(int Id)
        {
            var Class = await _lmsDbContext.Class
                        .AsNoTracking()
                        .FirstOrDefaultAsync(c => c.Class_Id == Id);

            return Class;
        }

        public async Task<int> UpdateClass(Class objClass)
        {
            try
            {
                _lmsDbContext.Class.Update(objClass);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }
    }

}