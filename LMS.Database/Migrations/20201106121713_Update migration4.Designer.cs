﻿// <auto-generated />
using System;
using LMS.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace LMS.Database.Migrations
{
    [DbContext(typeof(LmsDbContext))]
    [Migration("20201106121713_Update migration4")]
    partial class Updatemigration4
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.1.14-servicing-32113")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("LMS.Domain.Attendance", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Class_Id");

                    b.Property<string>("Date");

                    b.Property<int>("Section_Id");

                    b.Property<string>("Status");

                    b.Property<int>("Student_Id");

                    b.Property<string>("Student_Name");

                    b.Property<int>("Subject_Id");

                    b.Property<int>("Teacher_Id");

                    b.HasKey("Id");

                    b.HasIndex("Class_Id");

                    b.HasIndex("Section_Id");

                    b.HasIndex("Student_Id");

                    b.HasIndex("Subject_Id");

                    b.HasIndex("Teacher_Id");

                    b.ToTable("Attendance");
                });

            modelBuilder.Entity("LMS.Domain.Class", b =>
                {
                    b.Property<int>("Class_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Class_Name");

                    b.HasKey("Class_Id");

                    b.ToTable("Class");
                });

            modelBuilder.Entity("LMS.Domain.ClassSection", b =>
                {
                    b.Property<int>("ClassSection_id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Class_Id");

                    b.Property<int>("Section_Id");

                    b.HasKey("ClassSection_id");

                    b.HasIndex("Class_Id");

                    b.HasIndex("Section_Id");

                    b.ToTable("ClassSection");
                });

            modelBuilder.Entity("LMS.Domain.ClassSubject", b =>
                {
                    b.Property<int>("ClassSubject_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("ClassSection_Id");

                    b.Property<int>("Subject_Id");

                    b.HasKey("ClassSubject_Id");

                    b.HasIndex("ClassSection_Id");

                    b.HasIndex("Subject_Id");

                    b.ToTable("ClassSubject");
                });

            modelBuilder.Entity("LMS.Domain.Grade", b =>
                {
                    b.Property<int>("Grade_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Class_Id");

                    b.Property<int>("End_On");

                    b.Property<string>("Grade_Name");

                    b.Property<int>("Section_Id");

                    b.Property<int>("Start_From");

                    b.Property<int>("Subject_Id");

                    b.HasKey("Grade_Id");

                    b.HasIndex("Class_Id");

                    b.HasIndex("Section_Id");

                    b.HasIndex("Subject_Id");

                    b.ToTable("Grade");
                });

            modelBuilder.Entity("LMS.Domain.Lecture", b =>
                {
                    b.Property<int>("Lecture_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("ClassSubject_Id");

                    b.Property<string>("LecturePost_Date");

                    b.Property<string>("Lecture_Detail");

                    b.Property<string>("Lecture_File");

                    b.Property<string>("Lecture_Name");

                    b.Property<int>("Teacher_Id");

                    b.HasKey("Lecture_Id");

                    b.HasIndex("ClassSubject_Id");

                    b.HasIndex("Teacher_Id");

                    b.ToTable("Lecture");
                });

            modelBuilder.Entity("LMS.Domain.Section", b =>
                {
                    b.Property<int>("Section_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Section_Name");

                    b.HasKey("Section_Id");

                    b.ToTable("Section");
                });

            modelBuilder.Entity("LMS.Domain.Session", b =>
                {
                    b.Property<int>("Session_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Class_Id");

                    b.Property<string>("Date");

                    b.Property<string>("End_Time");

                    b.Property<int>("Section_Id");

                    b.Property<string>("Session_Name");

                    b.Property<string>("Start_Time");

                    b.Property<int>("Subject_Id");

                    b.Property<int>("Teacher_Id");

                    b.HasKey("Session_Id");

                    b.HasIndex("Class_Id");

                    b.HasIndex("Section_Id");

                    b.HasIndex("Subject_Id");

                    b.HasIndex("Teacher_Id");

                    b.ToTable("Session");
                });

            modelBuilder.Entity("LMS.Domain.Student", b =>
                {
                    b.Property<int>("Student_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Student_City");

                    b.Property<string>("Student_Cnic");

                    b.Property<string>("Student_Country");

                    b.Property<string>("Student_CurrentAddress");

                    b.Property<string>("Student_DOB");

                    b.Property<string>("Student_Email");

                    b.Property<string>("Student_FatherName");

                    b.Property<string>("Student_Gender");

                    b.Property<string>("Student_HomePhone");

                    b.Property<string>("Student_MobNumber");

                    b.Property<string>("Student_Name");

                    b.Property<string>("Student_PermenentAddress");

                    b.Property<string>("Student_Photo");

                    b.Property<string>("Student_Ref_Id");

                    b.HasKey("Student_Id");

                    b.ToTable("Student");
                });

            modelBuilder.Entity("LMS.Domain.StudentClass", b =>
                {
                    b.Property<int>("StudentClass_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("ClassSection_id");

                    b.Property<int>("Student_Id");

                    b.HasKey("StudentClass_Id");

                    b.HasIndex("ClassSection_id");

                    b.HasIndex("Student_Id");

                    b.ToTable("StudentClass");
                });

            modelBuilder.Entity("LMS.Domain.Subject", b =>
                {
                    b.Property<int>("Subject_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Subject_Name");

                    b.HasKey("Subject_Id");

                    b.ToTable("Subject");
                });

            modelBuilder.Entity("LMS.Domain.Teacher", b =>
                {
                    b.Property<int>("Teacher_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Teacher_City");

                    b.Property<string>("Teacher_Cnic");

                    b.Property<string>("Teacher_Country");

                    b.Property<string>("Teacher_CurrentAddress");

                    b.Property<string>("Teacher_DOB");

                    b.Property<string>("Teacher_Department");

                    b.Property<string>("Teacher_Designation");

                    b.Property<string>("Teacher_Email");

                    b.Property<string>("Teacher_FatherName");

                    b.Property<string>("Teacher_Gender");

                    b.Property<string>("Teacher_HomePhone");

                    b.Property<string>("Teacher_LastDegree");

                    b.Property<string>("Teacher_MobNumber");

                    b.Property<string>("Teacher_Name");

                    b.Property<string>("Teacher_PermenentAddress");

                    b.Property<string>("Teacher_Photo");

                    b.Property<string>("Teacher_Ref_Id");

                    b.HasKey("Teacher_Id");

                    b.ToTable("Teacher");
                });

            modelBuilder.Entity("LMS.Domain.TeacherSubject", b =>
                {
                    b.Property<int>("TeacherSubject_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("ClassSubject_Id");

                    b.Property<int>("Teacher_Id");

                    b.HasKey("TeacherSubject_Id");

                    b.HasIndex("ClassSubject_Id");

                    b.HasIndex("Teacher_Id");

                    b.ToTable("TeacherSubject");
                });

            modelBuilder.Entity("LMS.Domain.Test", b =>
                {
                    b.Property<int>("Test_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("Class_Id");

                    b.Property<string>("End_Time");

                    b.Property<int>("Passing_Makrs");

                    b.Property<int>("Section_Id");

                    b.Property<string>("Start_Time");

                    b.Property<int>("Subject_Id");

                    b.Property<int>("Teacher_Id");

                    b.Property<string>("Test_Instruction");

                    b.Property<string>("Test_Name");

                    b.Property<int>("Total_Makrs");

                    b.Property<int>("Weighatge");

                    b.HasKey("Test_Id");

                    b.HasIndex("Class_Id");

                    b.HasIndex("Section_Id");

                    b.HasIndex("Subject_Id");

                    b.HasIndex("Teacher_Id");

                    b.ToTable("Test");
                });

            modelBuilder.Entity("LMS.Domain.TestDetail", b =>
                {
                    b.Property<int>("Question_Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("Correct_Answer");

                    b.Property<string>("Option_1");

                    b.Property<string>("Option_2");

                    b.Property<string>("Option_3");

                    b.Property<string>("Option_4");

                    b.Property<string>("Question_Name");

                    b.Property<int>("Test_Id");

                    b.HasKey("Question_Id");

                    b.HasIndex("Test_Id");

                    b.ToTable("TestDetail");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Name")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("RoleId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUser", b =>
                {
                    b.Property<string>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<int>("AccessFailedCount");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken();

                    b.Property<string>("Email")
                        .HasMaxLength(256);

                    b.Property<bool>("EmailConfirmed");

                    b.Property<bool>("LockoutEnabled");

                    b.Property<DateTimeOffset?>("LockoutEnd");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256);

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256);

                    b.Property<string>("PasswordHash");

                    b.Property<string>("PhoneNumber");

                    b.Property<bool>("PhoneNumberConfirmed");

                    b.Property<string>("SecurityStamp");

                    b.Property<bool>("TwoFactorEnabled");

                    b.Property<string>("UserName")
                        .HasMaxLength(256);

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("AspNetUsers");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<string>("ClaimType");

                    b.Property<string>("ClaimValue");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider");

                    b.Property<string>("ProviderKey");

                    b.Property<string>("ProviderDisplayName");

                    b.Property<string>("UserId")
                        .IsRequired();

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("RoleId");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId");

                    b.Property<string>("LoginProvider");

                    b.Property<string>("Name");

                    b.Property<string>("Value");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens");
                });

            modelBuilder.Entity("LMS.Domain.Attendance", b =>
                {
                    b.HasOne("LMS.Domain.Class", "Class")
                        .WithMany()
                        .HasForeignKey("Class_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Section", "Section")
                        .WithMany()
                        .HasForeignKey("Section_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Student", "Student")
                        .WithMany()
                        .HasForeignKey("Student_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("Subject_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("Teacher_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.ClassSection", b =>
                {
                    b.HasOne("LMS.Domain.Class", "Class")
                        .WithMany()
                        .HasForeignKey("Class_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Section", "Section")
                        .WithMany()
                        .HasForeignKey("Section_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.ClassSubject", b =>
                {
                    b.HasOne("LMS.Domain.ClassSection", "ClassSection")
                        .WithMany()
                        .HasForeignKey("ClassSection_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("Subject_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.Grade", b =>
                {
                    b.HasOne("LMS.Domain.Class", "Class")
                        .WithMany()
                        .HasForeignKey("Class_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Section", "Section")
                        .WithMany()
                        .HasForeignKey("Section_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("Subject_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.Lecture", b =>
                {
                    b.HasOne("LMS.Domain.ClassSubject", "ClassSubject")
                        .WithMany()
                        .HasForeignKey("ClassSubject_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("Teacher_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.Session", b =>
                {
                    b.HasOne("LMS.Domain.Class", "Class")
                        .WithMany()
                        .HasForeignKey("Class_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Section", "Section")
                        .WithMany()
                        .HasForeignKey("Section_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("Subject_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("Teacher_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.StudentClass", b =>
                {
                    b.HasOne("LMS.Domain.ClassSection", "ClassSection")
                        .WithMany()
                        .HasForeignKey("ClassSection_id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Student", "Student")
                        .WithMany()
                        .HasForeignKey("Student_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.TeacherSubject", b =>
                {
                    b.HasOne("LMS.Domain.ClassSubject", "ClassSubject")
                        .WithMany()
                        .HasForeignKey("ClassSubject_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("Teacher_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.Test", b =>
                {
                    b.HasOne("LMS.Domain.Class", "Class")
                        .WithMany()
                        .HasForeignKey("Class_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Section", "Section")
                        .WithMany()
                        .HasForeignKey("Section_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Subject", "Subject")
                        .WithMany()
                        .HasForeignKey("Subject_Id")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("LMS.Domain.Teacher", "Teacher")
                        .WithMany()
                        .HasForeignKey("Teacher_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("LMS.Domain.TestDetail", b =>
                {
                    b.HasOne("LMS.Domain.Test", "Test")
                        .WithMany()
                        .HasForeignKey("Test_Id")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole")
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityUser")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade);
                });
#pragma warning restore 612, 618
        }
    }
}