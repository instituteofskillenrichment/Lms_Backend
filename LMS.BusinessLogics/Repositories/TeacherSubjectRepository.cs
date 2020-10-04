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
    public class TeacherSubjectRepository : ITeacherSubjectRepository
    {
        private LmsDbContext _lmsDbContext;

        public TeacherSubjectRepository(LmsDbContext lmsDbContext)
        {
            _lmsDbContext = lmsDbContext;
        }

        public async Task<int> AddTeacherSubject(TeacherSubject objTeacherSubject)
        {
            try
            {
                await _lmsDbContext.TeacherSubject.AddAsync(objTeacherSubject);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;

            }
        }


        public async Task<int> EditTeacherSubject(TeacherSubject objTeacherSubject)
        {
            try
            {
                 _lmsDbContext.TeacherSubject.Update(objTeacherSubject);
                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch (Exception ex)
            {
                return -1;

            }
        }


        public Task<TeacherSubjectViewModel> GetTeacherSubjectById(int TeacherSubject_Id)
        {
            var TeacherSubject = (

                                                                 from t in _lmsDbContext.Teacher
                                                                 join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                 join csub in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals csub.ClassSubject_Id
                                                                 join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                                 join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                                                 join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                                 join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                                                                 //where ts.TeacherSubject_Id == TeacherSubject_Id
                                                                 //orderby c.Class_Id, s.Section_Id
                                                                 select new TeacherSubjectViewModel
                                                                 {
                                                                     TeacherSubject_Id = ts.TeacherSubject_Id,
                                                                     Teacher_Id = t.Teacher_Id,
                                                                     Teacher_Name = t.Teacher_Name,
                                                                     ClassSubject_Id = csub.ClassSubject_Id,
                                                                     Subject_Id = sub.Subject_Id,
                                                                     Subject_Name = sub.Subject_Name,
                                                                     ClassSection_Id = csec.ClassSection_id,
                                                                     Class_Id = c.Class_Id,
                                                                     Class_Name = c.Class_Name,
                                                                     Section_Id = s.Section_Id,
                                                                     Section_Name = s.Section_Name

                                                                 }).AsNoTracking().FirstOrDefaultAsync(ts => ts.TeacherSubject_Id == TeacherSubject_Id) ;

            return TeacherSubject;
        }


        public async Task<int> DeleteTeacherSubject(int TeacherSubject_Id)
        {
            try
            {
                var objTeacherSubject = await GetTeacherSubjectById(TeacherSubject_Id);

                var deleteTeacherSubject = new TeacherSubject();
                deleteTeacherSubject.TeacherSubject_Id = objTeacherSubject.TeacherSubject_Id;
                deleteTeacherSubject.ClassSubject_Id = objTeacherSubject.ClassSubject_Id;
                deleteTeacherSubject.Teacher_Id = objTeacherSubject.Teacher_Id;
                
                _lmsDbContext.TeacherSubject.Remove(deleteTeacherSubject);

                await _lmsDbContext.SaveChangesAsync();

                return 1;
            }
            catch(Exception ex)
            {
                return -1;
            }
        }

        public List<Class> GetAllClasses()
        {
            List<Class> Classes = _lmsDbContext.Class.ToList();


            return Classes;
        }

        public List<Section> GetAllSections()
        {
            List<Section> Sections = _lmsDbContext.Section.ToList();

            return Sections;
        }

        public List<Subject> GetAllSubjects()
        {
            List<Subject> Subjects = _lmsDbContext.Subject.ToList();

            return Subjects;
        }

        public async Task<ClassSection> GetClassSectionById(int classId, int sectionId)
        {
            var ClassSection = await _lmsDbContext.ClassSection
                 .AsNoTracking()
                 .FirstOrDefaultAsync(cs => cs.Class_Id == classId && cs.Section_Id == sectionId);

            return ClassSection;
        }

        public async Task<ClassSubject> GetClassSubjectById(int classSectionId, int subjectId)
        {
            var ClassSubject = await _lmsDbContext.ClassSubject
                 .AsNoTracking()
                 .FirstOrDefaultAsync(csub => csub.ClassSection_Id == classSectionId && csub.Subject_Id == subjectId);

            return ClassSubject;
        }

        public List<ClassSubject> GetClassSubjectsById(int classSectionId)
        {
            var ClassSubject = _lmsDbContext.ClassSubject.Include(i => i.Subject)
                .Include(j => j.ClassSection.Class)
                .Where(csub => csub.ClassSection_Id == classSectionId).ToList();

            return ClassSubject;
        }

        public IQueryable<TeacherSubjectViewModel> GetTeacherClassSubjectstByTeacherId(int TeacherId)
        {
            IQueryable<TeacherSubjectViewModel> TeacherClassSubject = (

                                                                 from t in _lmsDbContext.Teacher
                                                                 join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                 join csub in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals csub.ClassSubject_Id
                                                                 join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                                 join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                                                 join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                                 join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                                                                 where t.Teacher_Id == TeacherId
                                                                 orderby c.Class_Id, s.Section_Id
                                                                 select new TeacherSubjectViewModel
                                                                 {
                                                                     TeacherSubject_Id = ts.TeacherSubject_Id,
                                                                     Teacher_Id = t.Teacher_Id,
                                                                     Teacher_Name = t.Teacher_Name,
                                                                     ClassSubject_Id = csub.ClassSubject_Id,
                                                                     Subject_Id = sub.Subject_Id,
                                                                     Subject_Name = sub.Subject_Name,
                                                                     ClassSection_Id = csec.ClassSection_id,
                                                                     Class_Id = c.Class_Id,
                                                                     Class_Name = c.Class_Name,
                                                                     Section_Id = s.Section_Id,
                                                                     Section_Name = s.Section_Name

                                                                 }).AsQueryable();

            return TeacherClassSubject;
        }

        public IQueryable<TeacherSubjectViewModel> GetTeacherSubjects()
        {
            IQueryable<TeacherSubjectViewModel> TeacherClass = (
                                                                 
                                                                 from t in _lmsDbContext.Teacher
                                                                 join ts in _lmsDbContext.TeacherSubject on t.Teacher_Id equals ts.Teacher_Id
                                                                 join csub in _lmsDbContext.ClassSubject on ts.ClassSubject_Id equals csub.ClassSubject_Id
                                                                 join sub in _lmsDbContext.Subject on csub.Subject_Id equals sub.Subject_Id
                                                                 join csec in _lmsDbContext.ClassSection on csub.ClassSection_Id equals csec.ClassSection_id
                                                                 join c in _lmsDbContext.Class on csec.Class_Id equals c.Class_Id
                                                                 join s in _lmsDbContext.Section on csec.Section_Id equals s.Section_Id
                                                                 orderby t.Teacher_Id, c.Class_Id, s.Section_Id
                                                                 select new TeacherSubjectViewModel
                                                                 {
                                                                     TeacherSubject_Id = ts.TeacherSubject_Id,
                                                                     Teacher_Id = t.Teacher_Id,
                                                                     Teacher_Name = t.Teacher_Name,
                                                                     ClassSubject_Id = csub.ClassSubject_Id,
                                                                     Subject_Id = sub.Subject_Id,
                                                                     Subject_Name = sub.Subject_Name,
                                                                     ClassSection_Id = csec.ClassSection_id,
                                                                     Class_Id = c.Class_Id,
                                                                     Class_Name = c.Class_Name,
                                                                     Section_Id = s.Section_Id,
                                                                     Section_Name = s.Section_Name
                                                                     
                                                                 }).AsQueryable();

            return TeacherClass;
        }

        //Added by Arib
        public IEnumerable<SubjectLectureViewModel> GetTeacherClassSubjectLectures(int TeacherId, int classSubjectId)
        {
            var TeacherClassSubjectWithLecture = (

                                                                 from sb in _lmsDbContext.Subject
                                                                 join csb in _lmsDbContext.ClassSubject on sb.Subject_Id equals csb.Subject_Id 
                                                                 join csc in _lmsDbContext.ClassSection on csb.ClassSection_Id equals csc.ClassSection_id
                                                                 join c in _lmsDbContext.Class on csc.Class_Id equals c.Class_Id
                                                                 join l in _lmsDbContext.Lecture on csb.ClassSubject_Id equals l.ClassSubject_Id
                                                                 where l.Teacher_Id == TeacherId && l.ClassSubject_Id == classSubjectId
                                                                 group new { c, sb, csb } by new { c.Class_Name, sb.Subject_Id, csb.ClassSubject_Id, sb.Subject_Name } into grp
                                                                 from l in grp.DefaultIfEmpty()
                                                                 select new SubjectLectureViewModel
                                                                 {
                                                                    Subject_Id = grp.Key.Subject_Id,
                                                                    Class_Name = grp.Key.Class_Name,
                                                                    Subject_Name = grp.Key.Subject_Name,
                                                                    ClassSubject_Id = grp.Key.ClassSubject_Id,
                                                                    Lecture_Count = grp.Count()
                                                                 }).ToList();

            return TeacherClassSubjectWithLecture;
        }
        
        //Added by Arib
        public async Task<ClassSubject> GetClassSubjectById(int classSectionId)
        {
            var ClassSubject = await _lmsDbContext.ClassSubject
                .AsNoTracking()
                .FirstOrDefaultAsync(csub => csub.ClassSection_Id == classSectionId);

            return ClassSubject;
        }
    }
}
