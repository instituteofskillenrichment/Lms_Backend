using System;
using System.Collections.Generic;
using System.Text;

namespace LMS.Domain.ViewModels
{
    public class EditLectureViewModel : LectureViewModel
    {
        public int Id { get; set; }
        public string ExistingFilePath { get; set; }
    }
}
