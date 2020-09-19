using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class CreateTableTeacherSubject2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TeacherSubject",
                columns: table => new
                {
                    TeacherSubject_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Teacher_Id = table.Column<int>(nullable: false),
                    ClassSubject_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TeacherSubject", x => x.TeacherSubject_Id);
                    table.ForeignKey(
                        name: "FK_TeacherSubject_ClassSubject_ClassSubject_Id",
                        column: x => x.ClassSubject_Id,
                        principalTable: "ClassSubject",
                        principalColumn: "ClassSubject_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TeacherSubject_Teacher_Teacher_Id",
                        column: x => x.Teacher_Id,
                        principalTable: "Teacher",
                        principalColumn: "Teacher_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TeacherSubject_ClassSubject_Id",
                table: "TeacherSubject",
                column: "ClassSubject_Id");

            migrationBuilder.CreateIndex(
                name: "IX_TeacherSubject_Teacher_Id",
                table: "TeacherSubject",
                column: "Teacher_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TeacherSubject");
        }
    }
}
