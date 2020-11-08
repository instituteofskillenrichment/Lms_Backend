using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AddingTestDetailTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TestDetail",
                columns: table => new
                {
                    Question_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Question_Name = table.Column<string>(nullable: true),
                    Option_1 = table.Column<string>(nullable: true),
                    Option_2 = table.Column<string>(nullable: true),
                    Option_3 = table.Column<string>(nullable: true),
                    Option_4 = table.Column<string>(nullable: true),
                    Correct_Answer = table.Column<string>(nullable: true),
                    Test_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestDetail", x => x.Question_Id);
                    table.ForeignKey(
                        name: "FK_TestDetail_Test_Test_Id",
                        column: x => x.Test_Id,
                        principalTable: "Test",
                        principalColumn: "Test_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TestDetail_Test_Id",
                table: "TestDetail",
                column: "Test_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TestDetail");
        }
    }
}
