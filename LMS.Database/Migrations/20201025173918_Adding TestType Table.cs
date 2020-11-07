using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AddingTestTypeTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Test_Type_Id",
                table: "TestDetail",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "TestType",
                columns: table => new
                {
                    Test_Type_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Test_Type_Name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestType", x => x.Test_Type_Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TestDetail_Test_Type_Id",
                table: "TestDetail",
                column: "Test_Type_Id");

            migrationBuilder.AddForeignKey(
                name: "FK_TestDetail_TestType_Test_Type_Id",
                table: "TestDetail",
                column: "Test_Type_Id",
                principalTable: "TestType",
                principalColumn: "Test_Type_Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TestDetail_TestType_Test_Type_Id",
                table: "TestDetail");

            migrationBuilder.DropTable(
                name: "TestType");

            migrationBuilder.DropIndex(
                name: "IX_TestDetail_Test_Type_Id",
                table: "TestDetail");

            migrationBuilder.DropColumn(
                name: "Test_Type_Id",
                table: "TestDetail");
        }
    }
}
