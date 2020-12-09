using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AddingTestDetailTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Test",
                columns: table => new
                {
                    Test_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Test_Name = table.Column<string>(nullable: true),
                    Test_Instruction = table.Column<string>(nullable: true),
                    Start_Time = table.Column<string>(nullable: true),
                    End_Time = table.Column<string>(nullable: true),
                    Total_Makrs = table.Column<int>(nullable: false),
                    Passing_Makrs = table.Column<int>(nullable: false),
                    Weighatge = table.Column<int>(nullable: false),
                    Teacher_Id = table.Column<int>(nullable: false),
                    Class_Id = table.Column<int>(nullable: false),
                    Section_Id = table.Column<int>(nullable: false),
                    Subject_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Test", x => x.Test_Id);
                    table.ForeignKey(
                        name: "FK_Test_Class_Class_Id",
                        column: x => x.Class_Id,
                        principalTable: "Class",
                        principalColumn: "Class_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Test_Section_Section_Id",
                        column: x => x.Section_Id,
                        principalTable: "Section",
                        principalColumn: "Section_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Test_Subject_Subject_Id",
                        column: x => x.Subject_Id,
                        principalTable: "Subject",
                        principalColumn: "Subject_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Test_Teacher_Teacher_Id",
                        column: x => x.Teacher_Id,
                        principalTable: "Teacher",
                        principalColumn: "Teacher_Id",
                        onDelete: ReferentialAction.Cascade);
                });

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
                name: "IX_Test_Class_Id",
                table: "Test",
                column: "Class_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Test_Section_Id",
                table: "Test",
                column: "Section_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Test_Subject_Id",
                table: "Test",
                column: "Subject_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Test_Teacher_Id",
                table: "Test",
                column: "Teacher_Id");

            migrationBuilder.CreateIndex(
                name: "IX_TestDetail_Test_Id",
                table: "TestDetail",
                column: "Test_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TestDetail");

            migrationBuilder.DropTable(
                name: "Test");
        }
    }
}
