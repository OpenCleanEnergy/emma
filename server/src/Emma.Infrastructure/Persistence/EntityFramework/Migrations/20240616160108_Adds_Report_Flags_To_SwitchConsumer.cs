using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Emma.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Adds_Report_Flags_To_SwitchConsumer : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "HasReportedPowerConsumption",
                table: "SwitchConsumers",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "HasReportedTotalEnergyConsumption",
                table: "SwitchConsumers",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "HasReportedPowerConsumption",
                table: "SwitchConsumers");

            migrationBuilder.DropColumn(
                name: "HasReportedTotalEnergyConsumption",
                table: "SwitchConsumers");
        }
    }
}
