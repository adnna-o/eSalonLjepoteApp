using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSalonLjepote.Service.Migrations
{
    /// <inheritdoc />
    public partial class upData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "qAEybki99cFWoOAgVUJXwcoPy6o=", "QwOxabCkg0+zo2eGl6uWPQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "r3ihndbyy/Tbz/71pRVgqhUtvXA=", "AqdelFXaQR8TodjU+d2ytw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1003,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "gfWUCsK/xrtUiA2QxJCMVCUCBF8=", "jt5mKzNs4qpqWFfwQTT5Yw==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1004,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "uBb//wkJzPxH9cVag/CfOMy1dsI=", "omhOx1DRVPx39EuX21xnQA==" });

            migrationBuilder.UpdateData(
                table: "Korisnik",
                keyColumn: "KorisnikId",
                keyValue: 1005,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "25DEsb5SLZhFjJy2rAx4RsdwBoI=", "KluudHZSYVbTXZGyVtMhaA==" });

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1012,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 2, 14, 599, DateTimeKind.Local).AddTicks(5350));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1013,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 2, 14, 599, DateTimeKind.Local).AddTicks(5402));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1014,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 2, 14, 599, DateTimeKind.Local).AddTicks(5404));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1015,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 2, 14, 599, DateTimeKind.Local).AddTicks(5407));

            migrationBuilder.UpdateData(
                table: "KorisnikUloga",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1016,
                column: "DatumIzmjene",
                value: new DateTime(2025, 10, 22, 17, 2, 14, 599, DateTimeKind.Local).AddTicks(5409));
        }
    }
}
