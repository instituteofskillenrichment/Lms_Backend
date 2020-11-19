using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace LMS.Database.Migrations
{
    public partial class MyFirstMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            //migrationBuilder.CreateTable(
            //    name: "AspNetRoles",
            //    columns: table => new
            //    {
            //        Id = table.Column<string>(nullable: false),
            //        Name = table.Column<string>(maxLength: 256, nullable: true),
            //        NormalizedName = table.Column<string>(maxLength: 256, nullable: true),
            //        ConcurrencyStamp = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetRoles", x => x.Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "AspNetUsers",
            //    columns: table => new
            //    {
            //        Id = table.Column<string>(nullable: false),
            //        UserName = table.Column<string>(maxLength: 256, nullable: true),
            //        NormalizedUserName = table.Column<string>(maxLength: 256, nullable: true),
            //        Email = table.Column<string>(maxLength: 256, nullable: true),
            //        NormalizedEmail = table.Column<string>(maxLength: 256, nullable: true),
            //        EmailConfirmed = table.Column<bool>(nullable: false),
            //        PasswordHash = table.Column<string>(nullable: true),
            //        SecurityStamp = table.Column<string>(nullable: true),
            //        ConcurrencyStamp = table.Column<string>(nullable: true),
            //        PhoneNumber = table.Column<string>(nullable: true),
            //        PhoneNumberConfirmed = table.Column<bool>(nullable: false),
            //        TwoFactorEnabled = table.Column<bool>(nullable: false),
            //        LockoutEnd = table.Column<DateTimeOffset>(nullable: true),
            //        LockoutEnabled = table.Column<bool>(nullable: false),
            //        AccessFailedCount = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetUsers", x => x.Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Class",
            //    columns: table => new
            //    {
            //        Class_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Class_Name = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Class", x => x.Class_Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Section",
            //    columns: table => new
            //    {
            //        Section_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Section_Name = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Section", x => x.Section_Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Student",
            //    columns: table => new
            //    {
            //        Student_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Student_Name = table.Column<string>(nullable: true),
            //        Student_Cnic = table.Column<string>(nullable: true),
            //        Student_DOB = table.Column<string>(nullable: true),
            //        Student_Gender = table.Column<string>(nullable: true),
            //        Student_MobNumber = table.Column<string>(nullable: true),
            //        Student_Email = table.Column<string>(nullable: true),
            //        Student_FatherName = table.Column<string>(nullable: true),
            //        Student_CurrentAddress = table.Column<string>(nullable: true),
            //        Student_PermenentAddress = table.Column<string>(nullable: true),
            //        Student_HomePhone = table.Column<string>(nullable: true),
            //        Student_City = table.Column<string>(nullable: true),
            //        Student_Country = table.Column<string>(nullable: true),
            //        Student_Photo = table.Column<string>(nullable: true),
            //        Student_Ref_Id = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Student", x => x.Student_Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Subject",
            //    columns: table => new
            //    {
            //        Subject_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Subject_Name = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Subject", x => x.Subject_Id);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Teacher",
            //    columns: table => new
            //    {
            //        Teacher_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Teacher_Name = table.Column<string>(nullable: true),
            //        Teacher_Cnic = table.Column<string>(nullable: true),
            //        Teacher_DOB = table.Column<string>(nullable: true),
            //        Teacher_Gender = table.Column<string>(nullable: true),
            //        Teacher_MobNumber = table.Column<string>(nullable: true),
            //        Teacher_Email = table.Column<string>(nullable: true),
            //        Teacher_FatherName = table.Column<string>(nullable: true),
            //        Teacher_Designation = table.Column<string>(nullable: true),
            //        Teacher_Department = table.Column<string>(nullable: true),
            //        Teacher_LastDegree = table.Column<string>(nullable: true),
            //        Teacher_CurrentAddress = table.Column<string>(nullable: true),
            //        Teacher_PermenentAddress = table.Column<string>(nullable: true),
            //        Teacher_HomePhone = table.Column<string>(nullable: true),
            //        Teacher_City = table.Column<string>(nullable: true),
            //        Teacher_Country = table.Column<string>(nullable: true),
            //        Teacher_Photo = table.Column<string>(nullable: true),
            //        Teacher_Ref_Id = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Teacher", x => x.Teacher_Id);
            //    });

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

            //migrationBuilder.CreateTable(
            //    name: "AspNetRoleClaims",
            //    columns: table => new
            //    {
            //        Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        RoleId = table.Column<string>(nullable: false),
            //        ClaimType = table.Column<string>(nullable: true),
            //        ClaimValue = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
            //        table.ForeignKey(
            //            name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
            //            column: x => x.RoleId,
            //            principalTable: "AspNetRoles",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "AspNetUserClaims",
            //    columns: table => new
            //    {
            //        Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        UserId = table.Column<string>(nullable: false),
            //        ClaimType = table.Column<string>(nullable: true),
            //        ClaimValue = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
            //        table.ForeignKey(
            //            name: "FK_AspNetUserClaims_AspNetUsers_UserId",
            //            column: x => x.UserId,
            //            principalTable: "AspNetUsers",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "AspNetUserLogins",
            //    columns: table => new
            //    {
            //        LoginProvider = table.Column<string>(nullable: false),
            //        ProviderKey = table.Column<string>(nullable: false),
            //        ProviderDisplayName = table.Column<string>(nullable: true),
            //        UserId = table.Column<string>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
            //        table.ForeignKey(
            //            name: "FK_AspNetUserLogins_AspNetUsers_UserId",
            //            column: x => x.UserId,
            //            principalTable: "AspNetUsers",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "AspNetUserRoles",
            //    columns: table => new
            //    {
            //        UserId = table.Column<string>(nullable: false),
            //        RoleId = table.Column<string>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
            //        table.ForeignKey(
            //            name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
            //            column: x => x.RoleId,
            //            principalTable: "AspNetRoles",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_AspNetUserRoles_AspNetUsers_UserId",
            //            column: x => x.UserId,
            //            principalTable: "AspNetUsers",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "AspNetUserTokens",
            //    columns: table => new
            //    {
            //        UserId = table.Column<string>(nullable: false),
            //        LoginProvider = table.Column<string>(nullable: false),
            //        Name = table.Column<string>(nullable: false),
            //        Value = table.Column<string>(nullable: true)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
            //        table.ForeignKey(
            //            name: "FK_AspNetUserTokens_AspNetUsers_UserId",
            //            column: x => x.UserId,
            //            principalTable: "AspNetUsers",
            //            principalColumn: "Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "ClassSection",
            //    columns: table => new
            //    {
            //        ClassSection_id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Class_Id = table.Column<int>(nullable: false),
            //        Section_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_ClassSection", x => x.ClassSection_id);
            //        table.ForeignKey(
            //            name: "FK_ClassSection_Class_Class_Id",
            //            column: x => x.Class_Id,
            //            principalTable: "Class",
            //            principalColumn: "Class_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_ClassSection_Section_Section_Id",
            //            column: x => x.Section_Id,
            //            principalTable: "Section",
            //            principalColumn: "Section_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Grade",
            //    columns: table => new
            //    {
            //        Grade_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Grade_Name = table.Column<string>(nullable: true),
            //        Start_From = table.Column<int>(nullable: false),
            //        End_On = table.Column<int>(nullable: false),
            //        Class_Id = table.Column<int>(nullable: false),
            //        Section_Id = table.Column<int>(nullable: false),
            //        Subject_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Grade", x => x.Grade_Id);
            //        table.ForeignKey(
            //            name: "FK_Grade_Class_Class_Id",
            //            column: x => x.Class_Id,
            //            principalTable: "Class",
            //            principalColumn: "Class_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Grade_Section_Section_Id",
            //            column: x => x.Section_Id,
            //            principalTable: "Section",
            //            principalColumn: "Section_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Grade_Subject_Subject_Id",
            //            column: x => x.Subject_Id,
            //            principalTable: "Subject",
            //            principalColumn: "Subject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Session",
            //    columns: table => new
            //    {
            //        Session_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Session_Name = table.Column<string>(nullable: true),
            //        Date = table.Column<string>(nullable: true),
            //        Start_Time = table.Column<string>(nullable: true),
            //        End_Time = table.Column<string>(nullable: true),
            //        Class_Id = table.Column<int>(nullable: false),
            //        Section_Id = table.Column<int>(nullable: false),
            //        Subject_Id = table.Column<int>(nullable: false),
            //        Teacher_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Session", x => x.Session_Id);
            //        table.ForeignKey(
            //            name: "FK_Session_Class_Class_Id",
            //            column: x => x.Class_Id,
            //            principalTable: "Class",
            //            principalColumn: "Class_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Session_Section_Section_Id",
            //            column: x => x.Section_Id,
            //            principalTable: "Section",
            //            principalColumn: "Section_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Session_Subject_Subject_Id",
            //            column: x => x.Subject_Id,
            //            principalTable: "Subject",
            //            principalColumn: "Subject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Session_Teacher_Teacher_Id",
            //            column: x => x.Teacher_Id,
            //            principalTable: "Teacher",
            //            principalColumn: "Teacher_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Test",
            //    columns: table => new
            //    {
            //        Test_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Test_Name = table.Column<string>(nullable: true),
            //        Test_Instruction = table.Column<string>(nullable: true),
            //        Start_Time = table.Column<string>(nullable: true),
            //        End_Time = table.Column<string>(nullable: true),
            //        Total_Makrs = table.Column<int>(nullable: false),
            //        Passing_Makrs = table.Column<int>(nullable: false),
            //        Weighatge = table.Column<int>(nullable: false),
            //        Teacher_Id = table.Column<int>(nullable: false),
            //        Class_Id = table.Column<int>(nullable: false),
            //        Section_Id = table.Column<int>(nullable: false),
            //        Subject_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Test", x => x.Test_Id);
            //        table.ForeignKey(
            //            name: "FK_Test_Class_Class_Id",
            //            column: x => x.Class_Id,
            //            principalTable: "Class",
            //            principalColumn: "Class_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Test_Section_Section_Id",
            //            column: x => x.Section_Id,
            //            principalTable: "Section",
            //            principalColumn: "Section_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Test_Subject_Subject_Id",
            //            column: x => x.Subject_Id,
            //            principalTable: "Subject",
            //            principalColumn: "Subject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Test_Teacher_Teacher_Id",
            //            column: x => x.Teacher_Id,
            //            principalTable: "Teacher",
            //            principalColumn: "Teacher_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "ClassSubject",
            //    columns: table => new
            //    {
            //        ClassSubject_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Subject_Id = table.Column<int>(nullable: false),
            //        ClassSection_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_ClassSubject", x => x.ClassSubject_Id);
            //        table.ForeignKey(
            //            name: "FK_ClassSubject_ClassSection_ClassSection_Id",
            //            column: x => x.ClassSection_Id,
            //            principalTable: "ClassSection",
            //            principalColumn: "ClassSection_id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_ClassSubject_Subject_Subject_Id",
            //            column: x => x.Subject_Id,
            //            principalTable: "Subject",
            //            principalColumn: "Subject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "StudentClass",
            //    columns: table => new
            //    {
            //        StudentClass_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Student_Id = table.Column<int>(nullable: false),
            //        ClassSection_id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_StudentClass", x => x.StudentClass_Id);
            //        table.ForeignKey(
            //            name: "FK_StudentClass_ClassSection_ClassSection_id",
            //            column: x => x.ClassSection_id,
            //            principalTable: "ClassSection",
            //            principalColumn: "ClassSection_id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_StudentClass_Student_Student_Id",
            //            column: x => x.Student_Id,
            //            principalTable: "Student",
            //            principalColumn: "Student_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "Attendance",
            //    columns: table => new
            //    {
            //        Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Date = table.Column<string>(nullable: true),
            //        Status = table.Column<string>(nullable: true),
            //        Session_Id = table.Column<int>(nullable: false),
            //        Student_Id = table.Column<int>(nullable: false),
            //        Student_Name = table.Column<string>(nullable: true),
            //        Class_Id = table.Column<int>(nullable: false),
            //        Section_Id = table.Column<int>(nullable: false),
            //        Subject_Id = table.Column<int>(nullable: false),
            //        Teacher_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Attendance", x => x.Id);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Class_Class_Id",
            //            column: x => x.Class_Id,
            //            principalTable: "Class",
            //            principalColumn: "Class_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Section_Section_Id",
            //            column: x => x.Section_Id,
            //            principalTable: "Section",
            //            principalColumn: "Section_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Session_Session_Id",
            //            column: x => x.Session_Id,
            //            principalTable: "Session",
            //            principalColumn: "Session_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Student_Student_Id",
            //            column: x => x.Student_Id,
            //            principalTable: "Student",
            //            principalColumn: "Student_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Subject_Subject_Id",
            //            column: x => x.Subject_Id,
            //            principalTable: "Subject",
            //            principalColumn: "Subject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Attendance_Teacher_Teacher_Id",
            //            column: x => x.Teacher_Id,
            //            principalTable: "Teacher",
            //            principalColumn: "Teacher_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

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
                    Test_Id = table.Column<int>(nullable: false),
                    Test_Type_Id = table.Column<int>(nullable: false)
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
                    table.ForeignKey(
                        name: "FK_TestDetail_TestType_Test_Type_Id",
                        column: x => x.Test_Type_Id,
                        principalTable: "TestType",
                        principalColumn: "Test_Type_Id",
                        onDelete: ReferentialAction.Cascade);
                });

            //migrationBuilder.CreateTable(
            //    name: "Lecture",
            //    columns: table => new
            //    {
            //        Lecture_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Lecture_Name = table.Column<string>(nullable: true),
            //        Lecture_Detail = table.Column<string>(nullable: true),
            //        Lecture_File = table.Column<string>(nullable: true),
            //        LecturePost_Date = table.Column<string>(nullable: true),
            //        Teacher_Id = table.Column<int>(nullable: false),
            //        ClassSubject_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_Lecture", x => x.Lecture_Id);
            //        table.ForeignKey(
            //            name: "FK_Lecture_ClassSubject_ClassSubject_Id",
            //            column: x => x.ClassSubject_Id,
            //            principalTable: "ClassSubject",
            //            principalColumn: "ClassSubject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_Lecture_Teacher_Teacher_Id",
            //            column: x => x.Teacher_Id,
            //            principalTable: "Teacher",
            //            principalColumn: "Teacher_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateTable(
            //    name: "TeacherSubject",
            //    columns: table => new
            //    {
            //        TeacherSubject_Id = table.Column<int>(nullable: false)
            //            .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
            //        Teacher_Id = table.Column<int>(nullable: false),
            //        ClassSubject_Id = table.Column<int>(nullable: false)
            //    },
            //    constraints: table =>
            //    {
            //        table.PrimaryKey("PK_TeacherSubject", x => x.TeacherSubject_Id);
            //        table.ForeignKey(
            //            name: "FK_TeacherSubject_ClassSubject_ClassSubject_Id",
            //            column: x => x.ClassSubject_Id,
            //            principalTable: "ClassSubject",
            //            principalColumn: "ClassSubject_Id",
            //            onDelete: ReferentialAction.Cascade);
            //        table.ForeignKey(
            //            name: "FK_TeacherSubject_Teacher_Teacher_Id",
            //            column: x => x.Teacher_Id,
            //            principalTable: "Teacher",
            //            principalColumn: "Teacher_Id",
            //            onDelete: ReferentialAction.Cascade);
            //    });

            //migrationBuilder.CreateIndex(
            //    name: "IX_AspNetRoleClaims_RoleId",
            //    table: "AspNetRoleClaims",
            //    column: "RoleId");

            //migrationBuilder.CreateIndex(
            //    name: "RoleNameIndex",
            //    table: "AspNetRoles",
            //    column: "NormalizedName",
            //    unique: true,
            //    filter: "[NormalizedName] IS NOT NULL");

            //migrationBuilder.CreateIndex(
            //    name: "IX_AspNetUserClaims_UserId",
            //    table: "AspNetUserClaims",
            //    column: "UserId");

            //migrationBuilder.CreateIndex(
            //    name: "IX_AspNetUserLogins_UserId",
            //    table: "AspNetUserLogins",
            //    column: "UserId");

            //migrationBuilder.CreateIndex(
            //    name: "IX_AspNetUserRoles_RoleId",
            //    table: "AspNetUserRoles",
            //    column: "RoleId");

            //migrationBuilder.CreateIndex(
            //    name: "EmailIndex",
            //    table: "AspNetUsers",
            //    column: "NormalizedEmail");

            //migrationBuilder.CreateIndex(
            //    name: "UserNameIndex",
            //    table: "AspNetUsers",
            //    column: "NormalizedUserName",
            //    unique: true,
            //    filter: "[NormalizedUserName] IS NOT NULL");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Class_Id",
            //    table: "Attendance",
            //    column: "Class_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Section_Id",
            //    table: "Attendance",
            //    column: "Section_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Session_Id",
            //    table: "Attendance",
            //    column: "Session_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Student_Id",
            //    table: "Attendance",
            //    column: "Student_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Subject_Id",
            //    table: "Attendance",
            //    column: "Subject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Attendance_Teacher_Id",
            //    table: "Attendance",
            //    column: "Teacher_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_ClassSection_Class_Id",
            //    table: "ClassSection",
            //    column: "Class_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_ClassSection_Section_Id",
            //    table: "ClassSection",
            //    column: "Section_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_ClassSubject_ClassSection_Id",
            //    table: "ClassSubject",
            //    column: "ClassSection_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_ClassSubject_Subject_Id",
            //    table: "ClassSubject",
            //    column: "Subject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Grade_Class_Id",
            //    table: "Grade",
            //    column: "Class_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Grade_Section_Id",
            //    table: "Grade",
            //    column: "Section_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Grade_Subject_Id",
            //    table: "Grade",
            //    column: "Subject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Lecture_ClassSubject_Id",
            //    table: "Lecture",
            //    column: "ClassSubject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Lecture_Teacher_Id",
            //    table: "Lecture",
            //    column: "Teacher_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Session_Class_Id",
            //    table: "Session",
            //    column: "Class_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Session_Section_Id",
            //    table: "Session",
            //    column: "Section_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Session_Subject_Id",
            //    table: "Session",
            //    column: "Subject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Session_Teacher_Id",
            //    table: "Session",
            //    column: "Teacher_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_StudentClass_ClassSection_id",
            //    table: "StudentClass",
            //    column: "ClassSection_id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_StudentClass_Student_Id",
            //    table: "StudentClass",
            //    column: "Student_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_TeacherSubject_ClassSubject_Id",
            //    table: "TeacherSubject",
            //    column: "ClassSubject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_TeacherSubject_Teacher_Id",
            //    table: "TeacherSubject",
            //    column: "Teacher_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Test_Class_Id",
            //    table: "Test",
            //    column: "Class_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Test_Section_Id",
            //    table: "Test",
            //    column: "Section_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Test_Subject_Id",
            //    table: "Test",
            //    column: "Subject_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_Test_Teacher_Id",
            //    table: "Test",
            //    column: "Teacher_Id");

            //migrationBuilder.CreateIndex(
            //    name: "IX_TestDetail_Test_Id",
            //    table: "TestDetail",
            //    column: "Test_Id");

            migrationBuilder.CreateIndex(
                name: "IX_TestDetail_Test_Type_Id",
                table: "TestDetail",
                column: "Test_Type_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "Attendance");

            migrationBuilder.DropTable(
                name: "Grade");

            migrationBuilder.DropTable(
                name: "Lecture");

            migrationBuilder.DropTable(
                name: "StudentClass");

            migrationBuilder.DropTable(
                name: "TeacherSubject");

            migrationBuilder.DropTable(
                name: "TestDetail");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "Session");

            migrationBuilder.DropTable(
                name: "Student");

            migrationBuilder.DropTable(
                name: "ClassSubject");

            migrationBuilder.DropTable(
                name: "Test");

            migrationBuilder.DropTable(
                name: "TestType");

            migrationBuilder.DropTable(
                name: "ClassSection");

            migrationBuilder.DropTable(
                name: "Subject");

            migrationBuilder.DropTable(
                name: "Teacher");

            migrationBuilder.DropTable(
                name: "Class");

            migrationBuilder.DropTable(
                name: "Section");
        }
    }
}
