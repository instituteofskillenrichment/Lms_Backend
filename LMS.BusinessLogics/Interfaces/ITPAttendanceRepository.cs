using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ITPAttendanceRepository
    {
        IQueryable<AttendanceViewModel> GetAllSessionByTeacherId(int TeacherId);
        IQueryable<AttendanceViewModel> GetAllClassSectionByTeacherId(int TeacherId);
        IQueryable<AttendanceViewModel> GetAllSubjectByTeacherId(int TeacherId);

        IQueryable<AttendanceViewModel> GetAllStudentsClass();

        Task<Session> GetSessionById(int Id);

        Task<int> AddSession(Session objSession);
        Task<int> DeleteSession(int id);
        Task<int> UpdateSession(Session objSession);

    }
}
