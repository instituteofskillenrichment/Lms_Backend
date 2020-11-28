using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class AddTableAnnouncement : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Announcement",
                columns: table => new
                {
                    Announcement_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Announcement_Detail = table.Column<string>(nullable: true),
                    Announcement_Date = table.Column<string>(nullable: true),
                    Class_Id = table.Column<int>(nullable: false),
                    Section_Id = table.Column<int>(nullable: false),
                    Subject_Id = table.Column<int>(nullable: false),
                    Teacher_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Announcement", x => x.Announcement_Id);
                    table.ForeignKey(
                        name: "FK_Announcement_Class_Class_Id",
                        column: x => x.Class_Id,
                        principalTable: "Class",
                        principalColumn: "Class_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Announcement_Section_Section_Id",
                        column: x => x.Section_Id,
                        principalTable: "Section",
                        principalColumn: "Section_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Announcement_Subject_Subject_Id",
                        column: x => x.Subject_Id,
                        principalTable: "Subject",
                        principalColumn: "Subject_Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Announcement_Teacher_Teacher_Id",
                        column: x => x.Teacher_Id,
                        principalTable: "Teacher",
                        principalColumn: "Teacher_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Announcement_Class_Id",
                table: "Announcement",
                column: "Class_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Announcement_Section_Id",
                table: "Announcement",
                column: "Section_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Announcement_Subject_Id",
                table: "Announcement",
                column: "Subject_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Announcement_Teacher_Id",
                table: "Announcement",
                column: "Teacher_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Announcement");
        }
    }
}
