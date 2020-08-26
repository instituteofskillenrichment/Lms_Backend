using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class ClassRepository : IClassRepository
    {
        private LmsDbContext _lmsDbContext;

        public ClassRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task AddClass(Class objClass)
        {
            await _lmsDbContext.Class.AddAsync(objClass);
            await _lmsDbContext.SaveChangesAsync();

        }

        public async Task DeleteClass(int id)
        {
            var deleteClass = await GetClassById(id);

            _lmsDbContext.Class.Remove(deleteClass);

            await _lmsDbContext.SaveChangesAsync();
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

        public async Task UpdateClass(Class objClass)
        {
            _lmsDbContext.Class.Update(objClass);

            await _lmsDbContext.SaveChangesAsync();
        }
    }
}
