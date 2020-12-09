using LMS.Domain;
using LMS.Domain.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface IStudentClassRepository
    {
        IQueryable<StudentClassViewModel> GetAllStudentsClass();
        //IQueryable<StudentClassViewModel> GetAllStudentSubjects();
        IQueryable<StudentClassViewModel> GetStudentSubjectByStudentId(int StudentId);
        Task<StudentClassViewModel> GetSudentClassById(int Id);
        //Task<Student> GetStudentById(int Id);
        List<Class> GetAllClasses();
        List<Section> GetAllSections();
        Task<ClassSection> GetClassSectionById(int classId, int sectionId);
        //Student FindStudentById(int Id);
        Task<int> AddStudentClass(StudentClass objStudent);
        Task<int> UpdateStudentClass(StudentClass objStudentClass);
        Task<int> DeleteStudentClass(int id);
        //Task SaveChanges();
        IEnumerable<StudentTestViewModel> GetTestsByStudentId(int StudentId);
    }
}
