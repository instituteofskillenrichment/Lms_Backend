using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISPStudentAttendanceRepository
    {
        Task<IEnumerable<StudentAttendanceViewModel>> GetAllAttendance(int Student_Id);
    }
}
