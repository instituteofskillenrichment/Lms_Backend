using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISPAnnouncementRepository
    {
        Task<IEnumerable<StudentAnnouncementViewModel>> GetAllAnnouncement(int ClassSection_Id);
        Task<StudentAnnouncementViewModel> GetAnnouncementById(int Id);
    }
}
