using Microsoft.AspNetCore.Mvc;

namespace LMS.Areas.Teachers.Models
{
    [ModelBinder(BinderType = typeof(MyModelBinder))]
    public class Test
    {
        public string Question { get; set; }
        public string Option1 { get; set; }
        public string Option2 { get; set; }
        public string Option3 { get; set; }
        public string Option4 { get; set; }
        public string CorrectAns { get; set; }
        public string TestTypeId { get; set; }
    }
}
