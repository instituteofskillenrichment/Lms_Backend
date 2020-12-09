using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AlterSessionTableForAttandenceaddTeacherColumn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Teacher_Id",
                table: "Session",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Session_Teacher_Id",
                table: "Session",
                column: "Teacher_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Session_Teacher_Teacher_Id",
                table: "Session",
                column: "Teacher_Id",
                principalTable: "Teacher",
                principalColumn: "Teacher_Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Session_Teacher_Teacher_Id",
                table: "Session");

            migrationBuilder.DropIndex(
                name: "IX_Session_Teacher_Id",
                table: "Session");

            migrationBuilder.DropColumn(
                name: "Teacher_Id",
                table: "Session");
        }
    }
}
