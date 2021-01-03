using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISPSubjectLectureRepository
    {
        Task<IEnumerable<StudentLectureViewModel>> GetAllSubjectLecture(int ClassSubject_Id);
        Task<EditLectureViewModel> GetLectureById(int Id);
    }
}
