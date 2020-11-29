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
    public class AnnouncementReporitory : IAnnouncementReporitory
    {
        private LmsDbContext _lmsDbContext;

        public AnnouncementReporitory(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddAnnouncement(Announcement objAnnouncement)
        {
            try
            {
                await _lmsDbContext.Announcement.AddAsync(objAnnouncement);
                await _lmsDbContext.SaveChangesAsync();

                return 1;

            }
            catch (Exception ex)
            {
                // _logger.LogError($"The message is {ex.Message}. " + $"Stack trace is {ex.StackTrace}");
                return -1;

            }
        }

        public async Task<int> DeleteAnnouncement(int id)
        {
            try
            {
                var deleteAnnouncement = await GetAnnouncementById(id);

                _lmsDbContext.Announcement.Remove(deleteAnnouncement);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        public async Task<Announcement> GetAnnouncementById(int Id)
        {
            var Announcement = await _lmsDbContext.Announcement
                        .AsNoTracking()
                        .FirstOrDefaultAsync(a => a.Announcement_Id == Id);

            return Announcement;
        }

        public IQueryable<AnnouncementViewModel> GetAnnouncementtByTeacherId(int TeacherId)
        {
            var AnnouncementList = (
                                        from a in _lmsDbContext.Announcement
                                        join t in _lmsDbContext.Teacher on a.Teacher_Id equals(t.Teacher_Id)
                                        join tsub in _lmsDbContext.TeacherSubject on t.Teacher_Id equals(tsub.Teacher_Id)
                                        join csub in _lmsDbContext.ClassSubject on tsub.ClassSubject_Id equals(csub.ClassSubject_Id)
                                        join sub in _lmsDbContext.Subject on csub.Subject_Id equals(sub.Subject_Id)
                                        join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals(csec.ClassSection_id)
                                        join c in _lmsDbContext.Class on csec.Class_Id equals(c.Class_Id)
                                        join sec in _lmsDbContext.Section on csec.Section_Id equals(sec.Section_Id)
                                        where
                                          a.Teacher_Id == TeacherId &&
                                          a.Class_Id == c.Class_Id &&
                                          a.Section_Id == sec.Section_Id &&
                                          a.Subject_Id == sub.Subject_Id
                                        select new AnnouncementViewModel
                                        {
                                            Announcement_Id = a.Announcement_Id,
                                            Announcement_Detail = a.Announcement_Detail,
                                            Announcement_Date = DateTime.ParseExact(a.Announcement_Date, "yyyyMMdd", null),
                                            Class_Id = c.Class_Id,
                                            Class_Name = c.Class_Name,
                                            Section_Id = sec.Section_Id,
                                            Section_Name = sec.Section_Name,
                                            Subject_Id = sub.Subject_Id,
                                            Subject_Name = sub.Subject_Name
                                        }
                                    ).AsQueryable();


            

            return AnnouncementList;
        }

        public async Task<int> UpdateAnnouncement(Announcement objAnnouncement)
        {
            try
            {
                _lmsDbContext.Announcement.Update(objAnnouncement);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }

}
