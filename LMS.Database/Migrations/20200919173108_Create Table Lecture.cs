using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class CreateTableLecture : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Lecture",
                columns: table => new
                {
                    Lecture_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Lecture_Name = table.Column<string>(nullable: true),
                    Lecture_Detail = table.Column<string>(nullable: true),
                    Lecture_File = table.Column<string>(nullable: true),
                    LecturePost_Date = table.Column<string>(nullable: true),
                    Teacher_Id = table.Column<int>(nullable: false),
                    ClassSubject_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Lecture", x => x.Lecture_Id);
                    table.ForeignKey(
                        name: "FK_Lecture_ClassSubject_ClassSubject_Id",
                        column: x => x.ClassSubject_Id,
                        principalTable: "ClassSubject",
                        principalColumn: "ClassSubject_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Lecture_Teacher_Teacher_Id",
                        column: x => x.Teacher_Id,
                        principalTable: "Teacher",
                        principalColumn: "Teacher_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_ClassSubject_Id",
                table: "Lecture",
                column: "ClassSubject_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Lecture_Teacher_Id",
                table: "Lecture",
                column: "Teacher_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Lecture");
        }
    }
}
