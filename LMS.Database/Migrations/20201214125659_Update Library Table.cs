using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class UpdateLibraryTable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
           

            
            migrationBuilder.CreateTable(
                name: "Library",
                columns: table => new
                {
                    Book_Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Book_Name = table.Column<string>(nullable: true),
                    Book_Detail = table.Column<string>(nullable: true),
                    Book_File = table.Column<string>(nullable: true),
                    Book_Image = table.Column<string>(nullable: true),
                    BookCategory_Id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Library", x => x.Book_Id);
                    table.ForeignKey(
                        name: "FK_Library_BookCategory_BookCategory_Id",
                        column: x => x.BookCategory_Id,
                        principalTable: "BookCategory",
                        principalColumn: "BookCategory_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            
            
            
            
            migrationBuilder.CreateIndex(
                name: "IX_Library_BookCategory_Id",
                table: "Library",
                column: "BookCategory_Id");

            
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            
            
            
        }
    }
}
