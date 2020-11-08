using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class Updatemigration4 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Attendance_Session_Session_Id",
                table: "Attendance");

            migrationBuilder.DropIndex(
                name: "IX_Attendance_Session_Id",
                table: "Attendance");

            migrationBuilder.DropColumn(
                name: "Session_Id",
                table: "Attendance");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Session_Id",
                table: "Attendance",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_Session_Id",
                table: "Attendance",
                column: "Session_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Attendance_Session_Session_Id",
                table: "Attendance",
                column: "Session_Id",
                principalTable: "Session",
                principalColumn: "Session_Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
