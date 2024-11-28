using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.Migrations
{
    /// <inheritdoc />
    public partial class Add_Basic_Auth_Credentials : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BasicAuthCredentials",
                columns: table => new
                {
                    _PK = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Integration = table.Column<string>(type: "text", nullable: false),
                    OwnedBy = table.Column<string>(type: "text", nullable: false),
                    Username_Nonce = table.Column<string>(type: "text", nullable: false),
                    Username_Ciphertext = table.Column<string>(type: "text", nullable: false),
                    Username_Tag = table.Column<string>(type: "text", nullable: false),
                    Password_Nonce = table.Column<string>(type: "text", nullable: false),
                    Password_Ciphertext = table.Column<string>(type: "text", nullable: false),
                    Password_Tag = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BasicAuthCredentials", x => x._PK);
                });

            migrationBuilder.CreateIndex(
                name: "IX_BasicAuthCredentials_OwnedBy_Integration",
                table: "BasicAuthCredentials",
                columns: new[] { "OwnedBy", "Integration" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BasicAuthCredentials");
        }
    }
}
