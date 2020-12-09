using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class StudentTestDetailTableCreated : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "StudentTestDetail",
                columns: table => new
                {
                    Answer_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Answer = table.Column<string>(nullable: true),
                    Test_Id = table.Column<int>(nullable: false),
                    Student_Id = table.Column<int>(nullable: false),
                    Question_Id = table.Column<int>(nullable: false),
                    Test_Type_Id = table.Column<int>(nullable: false),
                    Answer_Type_Id = table.Column<int>(nullable: false),
                    SubmittedOn = table.Column<DateTime>(type: "DateTime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudentTestDetail", x => x.Answer_Id);
                    table.ForeignKey(
                        name: "FK_StudentTestDetail_TestType_Answer_Type_Id",
                        column: x => x.Answer_Type_Id,
                        principalTable: "TestType",
                        principalColumn: "Test_Type_Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StudentTestDetail_TestDetail_Question_Id",
                        column: x => x.Question_Id,
                        principalTable: "TestDetail",
                        principalColumn: "Question_Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StudentTestDetail_Student_Student_Id",
                        column: x => x.Student_Id,
                        principalTable: "Student",
                        principalColumn: "Student_Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StudentTestDetail_Test_Test_Id",
                        column: x => x.Test_Id,
                        principalTable: "Test",
                        principalColumn: "Test_Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StudentTestDetail_TestType_Test_Type_Id",
                        column: x => x.Test_Type_Id,
                        principalTable: "TestType",
                        principalColumn: "Test_Type_Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Answer_Type_Id",
                table: "StudentTestDetail",
                column: "Answer_Type_Id");

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Question_Id",
                table: "StudentTestDetail",
                column: "Question_Id");

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Student_Id",
                table: "StudentTestDetail",
                column: "Student_Id");

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Test_Id",
                table: "StudentTestDetail",
                column: "Test_Id");

            migrationBuilder.CreateIndex(
                name: "IX_StudentTestDetail_Test_Type_Id",
                table: "StudentTestDetail",
                column: "Test_Type_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StudentTestDetail");
        }
    }
}
