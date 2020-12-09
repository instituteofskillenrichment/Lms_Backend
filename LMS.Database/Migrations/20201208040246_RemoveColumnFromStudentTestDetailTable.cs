using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class RemoveColumnFromStudentTestDetailTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_StudentTestDetail_TestType_Test_Type_Id",
                table: "StudentTestDetail");

            migrationBuilder.DropIndex(
                name: "IX_StudentTestDetail_Test_Type_Id",
                table: "StudentTestDetail");

            migrationBuilder.DropColumn(
                name: "Test_Type_Id",
                table: "StudentTestDetail");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Test_Type_Id",
                table: "StudentTestDetail",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Test_Type_Id",
                table: "StudentTestDetail",
                column: "Test_Type_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_StudentTestDetail_TestType_Test_Type_Id",
                table: "StudentTestDetail",
                column: "Test_Type_Id",
                principalTable: "TestType",
                principalColumn: "Test_Type_Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
