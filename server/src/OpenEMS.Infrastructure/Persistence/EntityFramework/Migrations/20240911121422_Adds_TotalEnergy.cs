using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Adds_TotalEnergy : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "TotalEnergyConsumption",
                table: "SwitchConsumers",
                newName: "TotalEnergyConsumption_Value"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyProduction",
                table: "Producers",
                newName: "TotalEnergyProduction_Value"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyFeedIn",
                table: "ElectricityMeters",
                newName: "TotalEnergyFeedIn_Value"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyConsumption",
                table: "ElectricityMeters",
                newName: "TotalEnergyConsumption_Value"
            );

            migrationBuilder.AddColumn<double>(
                name: "TotalEnergyConsumption_LastReported",
                table: "SwitchConsumers",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0
            );

            migrationBuilder.AddColumn<double>(
                name: "TotalEnergyProduction_LastReported",
                table: "Producers",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0
            );

            migrationBuilder.AddColumn<double>(
                name: "TotalEnergyConsumption_LastReported",
                table: "ElectricityMeters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0
            );

            migrationBuilder.AddColumn<double>(
                name: "TotalEnergyFeedIn_LastReported",
                table: "ElectricityMeters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TotalEnergyConsumption_LastReported",
                table: "SwitchConsumers"
            );

            migrationBuilder.DropColumn(
                name: "TotalEnergyProduction_LastReported",
                table: "Producers"
            );

            migrationBuilder.DropColumn(
                name: "TotalEnergyConsumption_LastReported",
                table: "ElectricityMeters"
            );

            migrationBuilder.DropColumn(
                name: "TotalEnergyFeedIn_LastReported",
                table: "ElectricityMeters"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyConsumption_Value",
                table: "SwitchConsumers",
                newName: "TotalEnergyConsumption"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyProduction_Value",
                table: "Producers",
                newName: "TotalEnergyProduction"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyFeedIn_Value",
                table: "ElectricityMeters",
                newName: "TotalEnergyFeedIn"
            );

            migrationBuilder.RenameColumn(
                name: "TotalEnergyConsumption_Value",
                table: "ElectricityMeters",
                newName: "TotalEnergyConsumption"
            );
        }
    }
}
