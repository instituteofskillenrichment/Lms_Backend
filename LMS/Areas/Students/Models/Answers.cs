namespace LMS.Areas.Students.Models
{
    public class Answers
    {
        public string QuestionId { get; set; }
        public string StudentId { get; set; }
        public string Answer { get; set; }
        public string TestId { get; set; }
        public string AnswerTypeId { get; set; }
    }
}
