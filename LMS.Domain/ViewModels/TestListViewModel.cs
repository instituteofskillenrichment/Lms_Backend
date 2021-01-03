using System;

namespace LMS.Domain.ViewModels
{
    public class TestListViewModel
    {
        public int Test_Id { get; set; }
        public string Test_Name { get; set; }
        public int Questions_Count { get; set; }

        public int Attempts { get; set; }

        public int Class_Id { get; set; }
        public string Class_Name { get; set; }
        public int Section_Id { get; set; }
        public string Section_Name { get; set; }
        public int Subject_Id { get; set; }
        public string Subject_Name { get; set; }
        //Added By Absar
        public DateTime Assessment_Date { get; set; }

    }
}
