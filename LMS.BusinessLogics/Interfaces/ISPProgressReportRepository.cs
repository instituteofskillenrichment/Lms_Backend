using LMS.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMS.BusinessLogics.Interfaces
{
    public interface ISPProgressReportRepository
    {
        IQueryable<SpProgressReportByStudentId> GetProgressReportByStudentId(string StudentId);
        IQueryable<SpProgressReportByClassSectionId> GetProgressReportByClassSectionId(string ClassSectionIdId);

        IQueryable<Class> GetAllClass();
        IQueryable<Section> GetAllSection();
        Task<ClassSection> GetClassSectionById(int classId, int sectionId);

    }
}
