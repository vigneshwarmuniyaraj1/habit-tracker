using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HabitTracker.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddHabitFields : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Description",
                table: "Habits");

            migrationBuilder.RenameColumn(
                name: "Title",
                table: "Habits",
                newName: "Name");

            migrationBuilder.RenameColumn(
                name: "TargetCount",
                table: "Habits",
                newName: "FrequencyType");

            migrationBuilder.RenameColumn(
                name: "Frequency",
                table: "Habits",
                newName: "Category");

            migrationBuilder.AddColumn<bool>(
                name: "IsArchived",
                table: "Habits",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "StartDate",
                table: "Habits",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<List<int>>(
                name: "TargetDays",
                table: "Habits",
                type: "integer[]",
                nullable: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsArchived",
                table: "Habits");

            migrationBuilder.DropColumn(
                name: "StartDate",
                table: "Habits");

            migrationBuilder.DropColumn(
                name: "TargetDays",
                table: "Habits");

            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Habits",
                newName: "Title");

            migrationBuilder.RenameColumn(
                name: "FrequencyType",
                table: "Habits",
                newName: "TargetCount");

            migrationBuilder.RenameColumn(
                name: "Category",
                table: "Habits",
                newName: "Frequency");

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Habits",
                type: "text",
                nullable: true);
        }
    }
}
