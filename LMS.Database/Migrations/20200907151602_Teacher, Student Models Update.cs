using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class TeacherStudentModelsUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Teacher_City",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Cnic",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Country",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_CurrentAddress",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_DOB",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Department",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Designation",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Email",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_FatherName",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Gender",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_HomePhone",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_LastDegree",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_MobNumber",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_PermenentAddress",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Teacher_Photo",
                table: "Teacher",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_City",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_Cnic",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_Country",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_CurrentAddress",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_DOB",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_Email",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_FatherName",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_Gender",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_HomePhone",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_MobNumber",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_PermenentAddress",
                table: "Student",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Student_Photo",
                table: "Student",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Teacher_City",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Cnic",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Country",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_CurrentAddress",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_DOB",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Department",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Designation",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Email",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_FatherName",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Gender",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_HomePhone",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_LastDegree",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_MobNumber",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_PermenentAddress",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Teacher_Photo",
                table: "Teacher");

            migrationBuilder.DropColumn(
                name: "Student_City",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_Cnic",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_Country",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_CurrentAddress",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_DOB",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_Email",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_FatherName",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_Gender",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_HomePhone",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_MobNumber",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_PermenentAddress",
                table: "Student");

            migrationBuilder.DropColumn(
                name: "Student_Photo",
                table: "Student");
        }
    }
}
