using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AddGradeTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Grade",
                columns: table => new
                {
                    Grade_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Grade_Name = table.Column<string>(nullable: true),
                    Start_From = table.Column<int>(nullable: false),
                    End_On = table.Column<int>(nullable: false),
                    Class_Id = table.Column<int>(nullable: false),
                    Section_Id = table.Column<int>(nullable: false),
                    Subject_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grade", x => x.Grade_Id);
                    table.ForeignKey(
                        name: "FK_Grade_Class_Class_Id",
                        column: x => x.Class_Id,
                        principalTable: "Class",
                        principalColumn: "Class_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Grade_Section_Section_Id",
                        column: x => x.Section_Id,
                        principalTable: "Section",
                        principalColumn: "Section_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Grade_Subject_Subject_Id",
                        column: x => x.Subject_Id,
                        principalTable: "Subject",
                        principalColumn: "Subject_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Grade_Class_Id",
                table: "Grade",
                column: "Class_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Grade_Section_Id",
                table: "Grade",
                column: "Section_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Grade_Subject_Id",
                table: "Grade",
                column: "Subject_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Grade");
        }
    }
}
