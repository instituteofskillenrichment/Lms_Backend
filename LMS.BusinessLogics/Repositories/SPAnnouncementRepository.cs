using LMS.BusinessLogics.Interfaces;
using LMS.Database;
using LMS.Domain;
using LMS.Domain.ViewModels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Repositories
{
    public class SPAnnouncementRepository : ISPAnnouncementRepository
    {
        private LmsDbContext _lmsDbContext;

        public SPAnnouncementRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<IEnumerable<StudentAnnouncementViewModel>> GetAllAnnouncement(int ClassSection_Id)
        {
            var listOfAnnouncement = await (
                                            from a in _lmsDbContext.Announcement
                                            join csec in _lmsDbContext.ClassSection on new { a.Class_Id, a.Section_Id } equals new { csec.Class_Id, csec.Section_Id }
                                            join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                            join sec in _lmsDbContext.Section on csec.Section_Id equals sec.Section_Id
                                            join csub in _lmsDbContext.ClassSubject on csec.ClassSection_id equals csub.ClassSection_Id
                                            join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                            join sc in _lmsDbContext.StudentClass on csec.ClassSection_id equals sc.ClassSection_id
                                            join s in _lmsDbContext.Student on sc.Student_Id equals s.Student_Id
                                            
                                            where
                                              a.Class_Id == sc.ClassSection.Class_Id &&
                                              a.Section_Id == sc.ClassSection.Section_Id &&
                                              a.Subject_Id == csub.Subject_Id &&
                                              sc.ClassSection_id == ClassSection_Id
                                            orderby a.Announcement_Date descending
                                            select new StudentAnnouncementViewModel
                                            {
                                               Announcement_Id = a.Announcement_Id,
                                               Announcement_Detail = a.Announcement_Detail,
                                               Announcement_Date = DateTime.ParseExact(a.Announcement_Date, "yyyyMMdd", null),
                                                ClassSection_Id = sc.ClassSection.ClassSection_id,
                                               Class_Id = a.Class_Id,
                                                //Column1 = sc.ClassSection.Class.Class_Id,
                                               Class_Name= sc.ClassSection.Class.Class_Name,
                                               Section_Id= a.Section_Id,
                                                //Column2 = sc.ClassSection.Section.Section_Id,
                                               Section_Name=  sc.ClassSection.Section.Section_Name,
                                               Subject_Id = a.Subject_Id,
                                                //Column3 = (int?)sub.Subject_Id
                                               Subject_Name = sub.Subject_Name
                                            }
                                       ).ToListAsync();

            return listOfAnnouncement;
        }

        public async Task<StudentAnnouncementViewModel> GetAnnouncementById(int Id)
        {
            var Announcement = await (
                                             from a in _lmsDbContext.Announcement
                                             join csec in _lmsDbContext.ClassSection on new { a.Class_Id, a.Section_Id } equals new { csec.Class_Id, csec.Section_Id }
                                             join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                             join sec in _lmsDbContext.Section on csec.Section_Id equals sec.Section_Id
                                             join csub in _lmsDbContext.ClassSubject on csec.ClassSection_id equals csub.ClassSection_Id
                                             join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                             join sc in _lmsDbContext.StudentClass on csec.ClassSection_id equals sc.ClassSection_id
                                             join s in _lmsDbContext.Student on sc.Student_Id equals s.Student_Id

                                             where
                                               a.Class_Id == sc.ClassSection.Class_Id &&
                                               a.Section_Id == sc.ClassSection.Section_Id &&
                                               a.Subject_Id == csub.Subject_Id &&
                                               a.Announcement_Id == Id
                                             orderby a.Announcement_Date descending
                                             select new StudentAnnouncementViewModel
                                             {
                                                 Announcement_Id = a.Announcement_Id,
                                                 Announcement_Detail = a.Announcement_Detail,
                                                 Announcement_Date = DateTime.ParseExact(a.Announcement_Date, "yyyyMMdd", null),
                                                 ClassSection_Id = sc.ClassSection.ClassSection_id,
                                                 Class_Id = a.Class_Id,
                                                //Column1 = sc.ClassSection.Class.Class_Id,
                                                Class_Name = sc.ClassSection.Class.Class_Name,
                                                 Section_Id = a.Section_Id,
                                                //Column2 = sc.ClassSection.Section.Section_Id,
                                                Section_Name = sc.ClassSection.Section.Section_Name,
                                                 Subject_Id = a.Subject_Id,
                                                //Column3 = (int?)sub.Subject_Id
                                                Subject_Name = sub.Subject_Name
                                             }
                                        ).AsNoTracking().FirstOrDefaultAsync();

            return Announcement;
        }
    }
}
