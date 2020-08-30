using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISubjectRepository
    {
        IQueryable<Subject> GetAllSubject();
        Task<Subject> GetSubjectById(int Id);
        Task AddSubject(Subject objSubject);
        Task UpdateSubject(Subject objSubject);
        Task DeleteSubject(int Id);
    }
}
