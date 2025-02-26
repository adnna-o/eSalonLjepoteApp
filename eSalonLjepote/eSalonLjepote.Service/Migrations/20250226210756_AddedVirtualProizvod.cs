using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSalonLjepote.Service.Migrations
{
    /// <inheritdoc />
    public partial class AddedVirtualProizvod : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+q+t1e3JaV5P0//4xdzxLyKM/Yc=", "MW6EEJWM2LkqalUtgybyVw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "KfWrDz27iFPl4lY5+M+0J58iyLs=", "NgcXsza/eiO3JsPe0qFyNQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "mbJTqUVTznG9BVffGRKivI6Q+4I=", "2wYC6zq17SfHL1O1Zc3csw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "aCqij8c/VAnn6YFo59Bnlen9tyY=", "8FW+jrn+Bf6GngFiHk8HYw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "uuA2G9/fkG2FmtnvD5m/uOHAP/A=", "NDMHqazczL1y6s8hTH3xDA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 22, 7, 55, 799, DateTimeKind.Local).AddTicks(5083));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 22, 7, 55, 799, DateTimeKind.Local).AddTicks(5146));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 22, 7, 55, 799, DateTimeKind.Local).AddTicks(5151));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 22, 7, 55, 799, DateTimeKind.Local).AddTicks(5155));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 5,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 26, 22, 7, 55, 799, DateTimeKind.Local).AddTicks(5158));

            migrationBuilder.CreateIndex(
                name: "IX_Recenzije_ProizvodId",
                table: "Recenzije",
                column: "ProizvodId");

            migrationBuilder.AddForeignKey(
                name: "FK_Recenzije_Proizvod_ProizvodId",
                table: "Recenzije",
                column: "ProizvodId",
                principalTable: "Proizvod",
                principalColumn: "ProizvodId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Recenzije_Proizvod_ProizvodId",
                table: "Recenzije");

            migrationBuilder.DropIndex(
                name: "IX_Recenzije_ProizvodId",
                table: "Recenzije");

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
        }
    }
}
