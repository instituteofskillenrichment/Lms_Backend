using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISectionRepository
    {
        IQueryable<Section> GetAllSection();
        Task<Section> GetSectionById(int Id);
        Task AddSection(Section objSection);
        Task UpdateSection(Section objSection);
        Task DeleteSection(int Id);
    }
}
