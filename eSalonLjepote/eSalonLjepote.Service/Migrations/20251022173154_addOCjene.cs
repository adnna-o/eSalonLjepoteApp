using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSalonLjepote.Service.Migrations
{
    /// <inheritdoc />
    public partial class addOCjene : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "OcjeneProizvoda",
                columns: table => new
                {
                    OcjeneProizvodaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ocjena = table.Column<int>(type: "int", maxLength: 20, nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    ProizvodId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OcjeneProizvoda", x => x.OcjeneProizvodaId);
                    table.ForeignKey(
                        name: "FK_OcjeneProizvoda_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OcjeneProizvoda_Proizvod_ProizvodId",
                        column: x => x.ProizvodId,
                        principalTable: "Proizvod",
                        principalColumn: "ProizvodId");
                });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "54AjhFvTZRK9NIn25/+uBmvg/8g=", "OwwHr+oYCCvYGwiIbSXc0g==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "/7JEzhEVGsb/EOouwQU0ZeTOqIQ=", "IBq36n3pGNkFrWg95ZoVEA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "QwSGKQX7vztHExSAtkvQSF8NiKI=", "iqlFaxXss50R3O7qQ2Dnjg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "BjR4cKDdendAkkeOlVYgFP/EPDQ=", "qwjiwKAdIm+oOw8OA7oswA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "U8zix0aloD604fVGGBDAZWPpapM=", "lGh0jQHLJkrNWDkkLpHNZA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1012,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 19, 31, 53, 937, DateTimeKind.Local).AddTicks(2890));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1013,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 19, 31, 53, 937, DateTimeKind.Local).AddTicks(2953));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1014,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 19, 31, 53, 937, DateTimeKind.Local).AddTicks(2957));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1015,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 19, 31, 53, 937, DateTimeKind.Local).AddTicks(2960));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1016,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 19, 31, 53, 937, DateTimeKind.Local).AddTicks(2963));

            migrationBuilder.CreateIndex(
                name: "IX_OcjeneProizvoda_KorisnikId",
                table: "OcjeneProizvoda",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_OcjeneProizvoda_ProizvodId",
                table: "OcjeneProizvoda",
                column: "ProizvodId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OcjeneProizvoda");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "/4JlrOqbPPb0Ud8M5EwyD9dc8JM=", "zm/S3feDcWmgDY2yqt35vg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ArX+BT3t1mkXec332xe+6XojN3I=", "x+BFfuP5UyTgBwXMTr7SLA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pp2r69CRIK/eEL+i/BqRG58gIoI=", "IYNilUTG40L1czOS+Kt3Zg==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+h5m64Pa1a0BnB8BUnr3zWiROq4=", "RAVENsE5+/PJu/M6gpKM4w==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "08cro4SIwJSTQc3FePXel1YOHEU=", "1jV6NUR2Xok75Ql6wVxjjA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1012,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 43, 24, 694, DateTimeKind.Local).AddTicks(4351));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1013,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 43, 24, 694, DateTimeKind.Local).AddTicks(4404));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1014,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 43, 24, 694, DateTimeKind.Local).AddTicks(4406));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1015,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 43, 24, 694, DateTimeKind.Local).AddTicks(4408));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1016,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 43, 24, 694, DateTimeKind.Local).AddTicks(4411));
        }
    }
}
