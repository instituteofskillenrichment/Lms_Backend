using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IAnnouncementReporitory
    {
        IQueryable<AnnouncementViewModel> GetAnnouncementtByTeacherId(int TeacherId);
        Task<int> AddAnnouncement(Announcement objAnnouncement);
    }
}
