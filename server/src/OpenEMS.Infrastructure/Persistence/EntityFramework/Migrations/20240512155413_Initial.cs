using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ElectricityMeters",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Integration_Integration = table.Column<string>(type: "text", nullable: false),
                    Integration_Device = table.Column<string>(type: "text", nullable: false),
                    CurrentPowerConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    MaximumPowerConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    CurrentPowerFeedIn = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    MaximumPowerFeedIn = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    TotalEnergyConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    TotalEnergyFeedIn = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityMeters", x => x.Id);
                }
            );

            migrationBuilder.CreateTable(
                name: "GrantedShellyDevices",
                columns: table => new
                {
                    _PK = table
                        .Column<int>(type: "integer", nullable: false)
                        .Annotation(
                            "Npgsql:ValueGenerationStrategy",
                            NpgsqlValueGenerationStrategy.IdentityByDefaultColumn
                        ),
                    DeviceId = table.Column<string>(type: "text", nullable: false),
                    DeviceType = table.Column<string>(type: "text", nullable: false),
                    DeviceCode = table.Column<string>(type: "text", nullable: false),
                    Host = table.Column<string>(type: "text", nullable: false),
                    Index = table.Column<int>(type: "integer", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GrantedShellyDevices", x => x._PK);
                }
            );

            migrationBuilder.CreateTable(
                name: "Producers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Integration_Integration = table.Column<string>(type: "text", nullable: false),
                    Integration_Device = table.Column<string>(type: "text", nullable: false),
                    CurrentPowerProduction = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    MaximumPowerProduction = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    TotalEnergyProduction = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Producers", x => x.Id);
                }
            );

            migrationBuilder.CreateTable(
                name: "SwitchConsumers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Integration_Integration = table.Column<string>(type: "text", nullable: false),
                    Integration_Device = table.Column<string>(type: "text", nullable: false),
                    Mode = table.Column<string>(type: "text", nullable: false),
                    SmartModeConfiguration_Nennleistung = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    SmartModeConfiguration_MinimaleEinschaltdauer = table.Column<TimeSpan>(
                        type: "interval",
                        nullable: false
                    ),
                    SmartModeConfiguration_Wiedereinschaltverzögerung = table.Column<TimeSpan>(
                        type: "interval",
                        nullable: false
                    ),
                    SwitchStatus = table.Column<string>(type: "text", nullable: false),
                    CurrentPowerConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    MaximumPowerConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    TotalEnergyConsumption = table.Column<double>(
                        type: "double precision",
                        nullable: false
                    ),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SwitchConsumers", x => x.Id);
                }
            );

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityMeters_Integration_Integration_Integration_Device",
                table: "ElectricityMeters",
                columns: new[] { "Integration_Integration", "Integration_Device" },
                unique: true
            );

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityMeters_OwnedBy",
                table: "ElectricityMeters",
                column: "OwnedBy"
            );

            migrationBuilder.CreateIndex(
                name: "IX_GrantedShellyDevices_DeviceId_Index",
                table: "GrantedShellyDevices",
                columns: new[] { "DeviceId", "Index" },
                unique: true
            );

            migrationBuilder.CreateIndex(
                name: "IX_GrantedShellyDevices_OwnedBy",
                table: "GrantedShellyDevices",
                column: "OwnedBy"
            );

            migrationBuilder.CreateIndex(
                name: "IX_Producers_Integration_Integration_Integration_Device",
                table: "Producers",
                columns: new[] { "Integration_Integration", "Integration_Device" },
                unique: true
            );

            migrationBuilder.CreateIndex(
                name: "IX_Producers_OwnedBy",
                table: "Producers",
                column: "OwnedBy"
            );

            migrationBuilder.CreateIndex(
                name: "IX_SwitchConsumers_Integration_Integration_Integration_Device",
                table: "SwitchConsumers",
                columns: new[] { "Integration_Integration", "Integration_Device" },
                unique: true
            );

            migrationBuilder.CreateIndex(
                name: "IX_SwitchConsumers_OwnedBy",
                table: "SwitchConsumers",
                column: "OwnedBy"
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(name: "ElectricityMeters");

            migrationBuilder.DropTable(name: "GrantedShellyDevices");

            migrationBuilder.DropTable(name: "Producers");

            migrationBuilder.DropTable(name: "SwitchConsumers");
        }
    }
}
