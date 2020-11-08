using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class Updatemigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Attendance");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Attendance",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Class_Id = table.Column<int>(nullable: false),
                    Date = table.Column<string>(nullable: true),
                    Section_Id = table.Column<int>(nullable: false),
                    Session_Id = table.Column<int>(nullable: false),
                    Status = table.Column<string>(nullable: true),
                    Student_Id = table.Column<int>(nullable: false),
                    Student_Name = table.Column<string>(nullable: true),
                    Subject_Id = table.Column<int>(nullable: false),
                    Teacher_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attendance", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Attendance_Class_Class_Id",
                        column: x => x.Class_Id,
                        principalTable: "Class",
                        principalColumn: "Class_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Section_Section_Id",
                        column: x => x.Section_Id,
                        principalTable: "Section",
                        principalColumn: "Section_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Session_Session_Id",
                        column: x => x.Session_Id,
                        principalTable: "Session",
                        principalColumn: "Session_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Student_Student_Id",
                        column: x => x.Student_Id,
                        principalTable: "Student",
                        principalColumn: "Student_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Subject_Subject_Id",
                        column: x => x.Subject_Id,
                        principalTable: "Subject",
                        principalColumn: "Subject_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Teacher_Teacher_Id",
                        column: x => x.Teacher_Id,
                        principalTable: "Teacher",
                        principalColumn: "Teacher_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Class_Id",
                table: "Attendance",
                column: "Class_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Section_Id",
                table: "Attendance",
                column: "Section_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Session_Id",
                table: "Attendance",
                column: "Session_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Student_Id",
                table: "Attendance",
                column: "Student_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Subject_Id",
                table: "Attendance",
                column: "Subject_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Teacher_Id",
                table: "Attendance",
                column: "Teacher_Id");
        }
    }
}
