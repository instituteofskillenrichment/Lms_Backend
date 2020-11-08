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
    public class TPClassRepository : ITPClassRepository
    {
        private LmsDbContext _lmsDbContext;

        public TPClassRepository(LmsDbContext lmsDbContext)
        {
             _lmsDbContext = lmsDbContext;
        }

        public async Task<ClassSection> GetClassSectionById(int classId, int sectionId)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                 .AsNoTracking()
                 .FirstOrDefaultAsync(cs => cs.Class_Id == classId && cs.Section_Id == sectionId);

            return ClassSection;
        }



        public async Task<ClassSubject> GetClassSubjectById(int classSectionId)
        {
            var ClassSubject = await _lmsDbContext.ClassSubject
                .AsNoTracking()
                .FirstOrDefaultAsync(csub => csub.ClassSection_Id == classSectionId);

            return ClassSubject;
        }


        //Added by Arib
        public IEnumerable<SubjectLectureViewModel> GetTeacherClassSubjectLectures(int TeacherId, int ClassSectionId)
        {

            var TeacherClassSubjectWithLecture = (
                                                    from ts in _lmsDbContext.TeacherSubject
                                                    where
                                                      ts.Teacher_Id == TeacherId &&
                                                      ts.ClassSubject.ClassSection_Id == ClassSectionId
                                                    select new SubjectLectureViewModel
                                                    {
                                                        Class_Name = ts.ClassSubject.ClassSection.Class.Class_Name,
                                                        Subject_Name = ts.ClassSubject.Subject.Subject_Name,
                                                        Subject_Id = ts.ClassSubject.Subject_Id,
                                                        ClassSubject_Id = ts.ClassSubject_Id,
                                                        Lecture_Count =
                                                        (from l in _lmsDbContext.Lecture
                                                         where
                                                         l.Teacher_Id == ts.Teacher_Id &&
                                                         ts.ClassSubject.ClassSubject_Id == l.ClassSubject.ClassSubject_Id
                                                         select new
                                                         {
                                                             l.Lecture_Name
                                                         }).Count(p => p.Lecture_Name != null)
                                                    }).ToList();



            return TeacherClassSubjectWithLecture;
        }


        public IQueryable<TeacherSubjectViewModel> GetTeacherClassSubjectstDistinctByTeacherId(int TeacherId)
        {
            IQueryable<TeacherSubjectViewModel> TeacherClassSubject =
                                                                    (from ts in _lmsDbContext.TeacherSubject
                                                                     where
                                                                       ts.Teacher_Id == TeacherId
                                                                     select new TeacherSubjectViewModel
                                                                     {
                                                                         Class_Id = ts.ClassSubject.ClassSection.Class.Class_Id,
                                                                         Class_Name = ts.ClassSubject.ClassSection.Class.Class_Name,
                                                                         Section_Name = ts.ClassSubject.ClassSection.Section.Section_Name,
                                                                         ClassSection_Id = ts.ClassSubject.ClassSection_Id
                                                                     }).AsQueryable().Distinct();

            return TeacherClassSubject;
        }
    }
}
