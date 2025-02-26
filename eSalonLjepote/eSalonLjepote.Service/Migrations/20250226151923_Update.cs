using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSalonLjepote.Service.Migrations
{
    /// <inheritdoc />
    public partial class Update : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "NarudzbaId",
                table: "Klijenti",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "UslugaId",
                table: "Klijenti",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Klijenti",
                keyColumn: "KlijentId",
                keyValue: 4001,
                columns: new[] { "NarudzbaId", "UslugaId" },
                values: new object[] { null, null });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ygV2kISr0hgAilmFdVzwCFRpdQk=", "eRQndkCJy0COKauMC5zHeA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "YIzF+CJP6kOSSt+1yycfXrI8Exo=", "AL93e7FvSS06KvjWmLGjgQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "R4f/Mq4wlh59KtWY59RciXz4wqE=", "bQX/G1KsA7S6Vr2cEChMzw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "QrmWXfqZMCDmDvSRS3A1+rZqzbY=", "AgeRNH394YrnrZ1D+mkVqw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "W7r66HgRU67t63dPtqACB6hV1mQ=", "dWKAVz5dpg0Vry8+qrf0qA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 16, 19, 23, 2, DateTimeKind.Local).AddTicks(951));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 16, 19, 23, 2, DateTimeKind.Local).AddTicks(1008));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 16, 19, 23, 2, DateTimeKind.Local).AddTicks(1016));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 16, 19, 23, 2, DateTimeKind.Local).AddTicks(1018));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 5,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 16, 19, 23, 2, DateTimeKind.Local).AddTicks(1020));

            migrationBuilder.UpdateData(
                table: "RadnoVrijeme",
                keyColumn: "RadnoVrijemeId",
                keyValue: 7001,
                columns: new[] { "RadnoVrijemeDo", "RadnoVrijemeOd" },
                values: new object[] { new DateTime(2025, 2, 26, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 2, 26, 8, 0, 0, 0, DateTimeKind.Unspecified) });

            migrationBuilder.CreateIndex(
                name: "IX_Klijenti_NarudzbaId",
                table: "Klijenti",
                column: "NarudzbaId");

            migrationBuilder.CreateIndex(
                name: "IX_Klijenti_UslugaId",
                table: "Klijenti",
                column: "UslugaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Klijenti_Narudzba_NarudzbaId",
                table: "Klijenti",
                column: "NarudzbaId",
                principalTable: "Narudzba",
                principalColumn: "NarudzbaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Klijenti_Usluga_UslugaId",
                table: "Klijenti",
                column: "UslugaId",
                principalTable: "Usluga",
                principalColumn: "UslugaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Klijenti_Narudzba_NarudzbaId",
                table: "Klijenti");

            migrationBuilder.DropForeignKey(
                name: "FK_Klijenti_Usluga_UslugaId",
                table: "Klijenti");

            migrationBuilder.DropIndex(
                name: "IX_Klijenti_NarudzbaId",
                table: "Klijenti");

            migrationBuilder.DropIndex(
                name: "IX_Klijenti_UslugaId",
                table: "Klijenti");

            migrationBuilder.DropColumn(
                name: "NarudzbaId",
                table: "Klijenti");

            migrationBuilder.DropColumn(
                name: "UslugaId",
                table: "Klijenti");

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "wrcBhxWUYGljGJ+Z7mCWuUQ2dUc=", "vP59GRCbgFu+i1lSKxF5ZQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "deCtkXNQCeaVwF9/EgfN6UphZak=", "aqlqVC7YhrWM0SnDjlRpIw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SaEE7S5kVtNtT37mAs0+kAo/PUU=", "yE6OiJC8frOAnu8Vv2fCRA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "77FQiD7F69YWSsUMEx8rxc+kqzQ=", "lZXMFsqfTB+VMt3G49TLbA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "u+cL0qa7MrlUbggkM4IK7SCXkYU=", "GYCfXpEOduS+ksZIMeKA3w==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 20, 14, 20, 39, 666, DateTimeKind.Local).AddTicks(9607));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 20, 14, 20, 39, 666, DateTimeKind.Local).AddTicks(9662));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 20, 14, 20, 39, 666, DateTimeKind.Local).AddTicks(9665));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 20, 14, 20, 39, 666, DateTimeKind.Local).AddTicks(9667));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 5,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 20, 14, 20, 39, 666, DateTimeKind.Local).AddTicks(9669));

            migrationBuilder.UpdateData(
                table: "RadnoVrijeme",
                keyColumn: "RadnoVrijemeId",
                keyValue: 7001,
                columns: new[] { "RadnoVrijemeDo", "RadnoVrijemeOd" },
                values: new object[] { new DateTime(2025, 2, 20, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 2, 20, 8, 0, 0, 0, DateTimeKind.Unspecified) });
        }
    }
}
