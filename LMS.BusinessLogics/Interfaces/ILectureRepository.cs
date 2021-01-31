using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ILectureRepository
    {
        IQueryable<Class> GetAllClass();
        IQueryable<Section> GetAllSection();
        IQueryable<Subject> GetAllSubject();
        Task<IEnumerable<EditLectureViewModel>> GetAllLecture(int TeachiId);
        Task<EditLectureViewModel> GetLectureById(int Id);
        Task<int> AddLecture(Lecture objLecture);
        Task<int> UpdateLecture(Lecture objLecture);
        Task<int> DeleteLecture(int id);
        Task<IEnumerable<Lecture>> GetLectureBySubject(int Id);

        //Added BY Absar
        IQueryable<LectureViewModel> GetAllClassSectionByTeacherId(int TeacherId);
        IQueryable<LectureViewModel> GetAllSubjectByTeacherId(int TeacherId);
        IQueryable<Lecture> GetRecentLecture();
    }
}
