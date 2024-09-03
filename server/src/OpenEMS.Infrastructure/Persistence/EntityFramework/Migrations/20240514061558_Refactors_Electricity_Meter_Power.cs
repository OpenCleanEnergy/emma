using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Refactors_Electricity_Meter_Power : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CurrentPowerConsumption",
                table: "ElectricityMeters"
            );

            migrationBuilder.RenameColumn(
                name: "CurrentPowerFeedIn",
                table: "ElectricityMeters",
                newName: "CurrentPower"
            );

            migrationBuilder.AddColumn<string>(
                name: "CurrentPowerDirection",
                table: "ElectricityMeters",
                type: "text",
                nullable: false,
                defaultValue: ""
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(name: "CurrentPowerDirection", table: "ElectricityMeters");

            migrationBuilder.RenameColumn(
                name: "CurrentPower",
                table: "ElectricityMeters",
                newName: "CurrentPowerFeedIn"
            );

            migrationBuilder.AddColumn<double>(
                name: "CurrentPowerConsumption",
                table: "ElectricityMeters",
                type: "double precision",
                nullable: false,
                defaultValue: 0.0
            );
        }
    }
}
