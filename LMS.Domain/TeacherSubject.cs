using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace LMS.Domain
{
    public class TeacherSubject
    {
        [Key]
        public int TeacherSubject_Id { get; set; }

        public Teacher Teacher { get; set; }
        public int Teacher_Id { get; set; }

        public ClassSubject ClassSubject { get; set; }
        public int ClassSubject_Id { get; set; }
    }
}
