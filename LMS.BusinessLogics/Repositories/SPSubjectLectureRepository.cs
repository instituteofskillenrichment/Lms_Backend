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
    public class SPSubjectLectureRepository : ISPSubjectLectureRepository
    {
        private LmsDbContext _lmsDbContext;

        public SPSubjectLectureRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<IEnumerable<StudentLectureViewModel>> GetAllSubjectLecture(int ClassSubject_Id)
        {
            var listOfLecture = await (
                                        from l in _lmsDbContext.Lecture
                                        where
                                          l.ClassSubject.ClassSubject_Id == ClassSubject_Id
                                        orderby
                                          l.LecturePost_Date descending
                                        select new StudentLectureViewModel
                                        {
                                            Lecture_Id = l.Lecture_Id,
                                           Lecture_Name =  l.Lecture_Name,
                                           Lecture_Detail = l.Lecture_Detail,
                                           Lecture_File =  l.Lecture_File,
                                           LecturePost_Date = DateTime.ParseExact(l.LecturePost_Date, "yyyyMMdd", null),
                                           Class_Id = l.ClassSubject.ClassSection.Class.Class_Id,
                                           Class_Name = l.ClassSubject.ClassSection.Class.Class_Name,
                                           Section_Id = l.ClassSubject.ClassSection.Section.Section_Id,
                                           Section_Name = l.ClassSubject.ClassSection.Section.Section_Name,
                                           Subject_Id = l.ClassSubject.Subject.Subject_Id,
                                           Subject_Name = l.ClassSubject.Subject.Subject_Name,
                                           // ClassSubject_Id = l.ClassSubject.ClassSubject_Id
                                        }
                                       ).ToListAsync();

            return listOfLecture;
        }

        public async Task<EditLectureViewModel> GetLectureById(int Id)
        {
            
            var Lecture = await (
                                    from l in _lmsDbContext.Lecture
                                    where
                                      l.Lecture_Id == Id &&
                                      l.ClassSubject_Id == l.ClassSubject.ClassSubject_Id &&
                                      l.ClassSubject.ClassSection_Id == l.ClassSubject.ClassSection.ClassSection_id &&
                                      l.ClassSubject.ClassSection.Section_Id == l.ClassSubject.ClassSection.Section.Section_Id &&
                                      l.ClassSubject.ClassSection.Class_Id == l.ClassSubject.ClassSection.Class.Class_Id &&
                                      l.ClassSubject.Subject_Id == l.ClassSubject.Subject.Subject_Id
                                    orderby
                                      l.Lecture_Id
                                    select new EditLectureViewModel
                                    {
                                        Id = l.Lecture_Id,
                                        Lecture_Name = l.Lecture_Name,
                                        Lecture_Detail = l.Lecture_Detail,
                                        LecturePost_Date = DateTime.ParseExact(l.LecturePost_Date, "yyyyMMdd", null),
                                        ExistingFilePath = l.Lecture_File,
                                        Class_Id = l.ClassSubject.ClassSection.Class.Class_Id,
                                        Class_Name = l.ClassSubject.ClassSection.Class.Class_Name,
                                        Section_Id = l.ClassSubject.ClassSection.Section.Section_Id,
                                        Section_Name = l.ClassSubject.ClassSection.Section.Section_Name,
                                        Subject_Id = l.ClassSubject.Subject.Subject_Id,
                                        Subject_Name = l.ClassSubject.Subject.Subject_Name
                                    }
                                ).AsNoTracking().FirstOrDefaultAsync();


            return Lecture;
        }

    }
}
