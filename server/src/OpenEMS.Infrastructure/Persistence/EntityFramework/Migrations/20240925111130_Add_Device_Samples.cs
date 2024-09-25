using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Add_Device_Samples : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ElectricityMeterSamples",
                columns: table => new
                {
                    _PK = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ElectricityMeterId = table.Column<Guid>(type: "uuid", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    CurrentPower = table.Column<double>(type: "double precision", nullable: false),
                    CurrentPowerDirection = table.Column<string>(type: "text", nullable: false),
                    TotalEnergyConsumption = table.Column<double>(type: "double precision", nullable: false),
                    TotalEnergyFeedIn = table.Column<double>(type: "double precision", nullable: false),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ElectricityMeterSamples", x => x._PK);
                });

            migrationBuilder.CreateTable(
                name: "ProducerSamples",
                columns: table => new
                {
                    _PK = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ProducerId = table.Column<Guid>(type: "uuid", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    CurrentPowerProduction = table.Column<double>(type: "double precision", nullable: false),
                    TotalEnergyProduction = table.Column<double>(type: "double precision", nullable: false),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProducerSamples", x => x._PK);
                });

            migrationBuilder.CreateTable(
                name: "SwitchConsumerSamples",
                columns: table => new
                {
                    _PK = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    SwitchConsumerId = table.Column<Guid>(type: "uuid", nullable: false),
                    Timestamp = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    CurrentPowerConsumption = table.Column<double>(type: "double precision", nullable: false),
                    TotalEnergyConsumption = table.Column<double>(type: "double precision", nullable: false),
                    OwnedBy = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SwitchConsumerSamples", x => x._PK);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityMeterSamples_OwnedBy",
                table: "ElectricityMeterSamples",
                column: "OwnedBy");

            migrationBuilder.CreateIndex(
                name: "IX_ElectricityMeterSamples_Timestamp",
                table: "ElectricityMeterSamples",
                column: "Timestamp");

            migrationBuilder.CreateIndex(
                name: "IX_ProducerSamples_OwnedBy",
                table: "ProducerSamples",
                column: "OwnedBy");

            migrationBuilder.CreateIndex(
                name: "IX_ProducerSamples_Timestamp",
                table: "ProducerSamples",
                column: "Timestamp");

            migrationBuilder.CreateIndex(
                name: "IX_SwitchConsumerSamples_OwnedBy",
                table: "SwitchConsumerSamples",
                column: "OwnedBy");

            migrationBuilder.CreateIndex(
                name: "IX_SwitchConsumerSamples_Timestamp",
                table: "SwitchConsumerSamples",
                column: "Timestamp");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ElectricityMeterSamples");

            migrationBuilder.DropTable(
                name: "ProducerSamples");

            migrationBuilder.DropTable(
                name: "SwitchConsumerSamples");
        }
    }
}
