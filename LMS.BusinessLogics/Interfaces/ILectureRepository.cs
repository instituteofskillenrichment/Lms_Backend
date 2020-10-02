using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ILectureRepository
    {
        IQueryable<Lecture> GetAllLecture();
        Task<Lecture> GetLectureById(int Id);
        Task AddLecture(Lecture objLecture);
        Task UpdateLecture(Lecture objLecture);
        Task DeleteLecture(int id);
        Task<IEnumerable<Lecture>> GetLectureBySubject(int Id);
    }
}
