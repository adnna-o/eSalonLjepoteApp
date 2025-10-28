using eSaljonLjepote.Services.Service;
using eSalonLjepote.Service.Database;
using eSalonLjepote.Service.Service;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eSaljonLjepote.Services.Database
{
    public static class Data
    {
        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];
            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);
            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public static void Seed(this ModelBuilder modelBuilder)
        {

            List<string> Salt = new List<string>();
            for (int i = 0; i < 5; i++)
            {
                Salt.Add(KorisnikService.GenerateSalt());
            }

            #region Dodavanje Korisnika
            var slikaAdmin = Convert.FromBase64String("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");
            string hash = "lC0njRakwHnzGX84ENFBeKvDvdE=";
            string salt = "7lw6ULAmd2KhTybM2m0/1A==";

            eSalonLjepote.Service.Database.Korisnik korisnik = new eSalonLjepote.Service.Database.Korisnik()
            {
                KorisnikId = 1001,
                Ime = "Adna",
                Prezime = "Obradovic",
                Spol = "Z",
                Telefon = "063 222 333",
                Email = "administrator@gmail.com",
                DatumRodjenja = new DateTime(1998, 12, 11),
                KorisnickoIme = "admin",
                Slika = slikaAdmin,
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik.LozinkaSalt = GenerateSalt();
            korisnik.LozinkaHash = GenerateHash(korisnik.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik);

            var slikaKorisnik = Convert.FromBase64String("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");
            eSalonLjepote.Service.Database.Korisnik korisnik2 = new eSalonLjepote.Service.Database.Korisnik()
            {
                KorisnikId = 1002,
                Ime = "Dzemila",
                Prezime = "Obradovic",
                Spol = "Z",
                Telefon = "063 111 333",
                Email = "korisnik@gmail.com",
                DatumRodjenja = new DateTime(1968,12, 11),
                KorisnickoIme = "korisnik",
                Slika = slikaKorisnik,
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik2.LozinkaSalt = GenerateSalt();
            korisnik2.LozinkaHash = GenerateHash(korisnik2.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik2);

            eSalonLjepote.Service.Database.Korisnik korisnik3 = new eSalonLjepote.Service.Database.Korisnik()
            {
                KorisnikId = 1003,
                Ime = "Medisa",
                Prezime = "Satara",
                Spol = "Z",
                Telefon = "063 111 333",
                Email = "zaposlenik@gmail.com",
                DatumRodjenja = new DateTime(1968, 12, 11),
                KorisnickoIme = "zaposlenik",
                Slika = slikaKorisnik,
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik3.LozinkaSalt = GenerateSalt();
            korisnik3.LozinkaHash = GenerateHash(korisnik3.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik3);
            eSalonLjepote.Service.Database.Korisnik korisnik4 = new eSalonLjepote.Service.Database.Korisnik()
            {
                KorisnikId = 1004,
                Ime = "Adna",
                Prezime = "Adna",
                Spol = "Z",
                Telefon = "063 111 333",
                Email = "zaposlenik@gmail.com",
                DatumRodjenja = new DateTime(1968, 12, 11),
                KorisnickoIme = "zaposlenik",
                Slika = slikaKorisnik,
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik4.LozinkaSalt = GenerateSalt();
            korisnik4.LozinkaHash = GenerateHash(korisnik4.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik4);

            eSalonLjepote.Service.Database.Korisnik korisnik5 = new eSalonLjepote.Service.Database.Korisnik()
            {
                KorisnikId = 1005,
                Ime = "Almina",
                Prezime = "Obradovic",
                Spol = "Z",
                Telefon = "063 111 333",
                Email = "zaposlenik@gmail.com",
                DatumRodjenja = new DateTime(1968, 12, 11),
                KorisnickoIme = "zaposlenik",
                Slika = slikaKorisnik,
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik5.LozinkaSalt = GenerateSalt();
            korisnik5.LozinkaHash = GenerateHash(korisnik5.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnik>().HasData(korisnik5);
            #endregion 

            #region Dodavanje Uloga
            modelBuilder.Entity<Uloga>().HasData(
                 new Uloga()
                 {
                     UlogaId = 1,
                     NazivUloge = "Admin",
                 },
                 new Uloga()
                 {
                     UlogaId = 2,
                     NazivUloge = "Korisnik",
                 },
                  new Uloga()
                  {
                      UlogaId = 3,
                      NazivUloge = "Zaposlenik",
                  }
                 );
            #endregion

            #region Dodavanje KorisnikUloga
            modelBuilder.Entity<KorisnikUloga>().HasData(
                new KorisnikUloga()
                {
                    KorisnikUlogaId = 1012,
                    KorisnikId = 1001,
                    UlogaId = 1,
                    DatumIzmjene = DateTime.Now
                },
                  new KorisnikUloga()
                  {
                      KorisnikUlogaId = 1013,
                      KorisnikId = 1002,
                      UlogaId = 2,
                      DatumIzmjene = DateTime.Now
                  },
                   new KorisnikUloga()
                   {
                       KorisnikUlogaId = 1014,
                       KorisnikId = 1003,
                       UlogaId = 3,
                       DatumIzmjene = DateTime.Now
                   },
                    new KorisnikUloga()
                    {
                        KorisnikUlogaId = 1015,
                        KorisnikId = 1004,
                        UlogaId = 3,
                        DatumIzmjene = DateTime.Now
                    },
                     new KorisnikUloga()
                     {
                         KorisnikUlogaId = 1016,
                         KorisnikId = 1005,
                         UlogaId = 3,
                         DatumIzmjene = DateTime.Now
                     });
            #endregion


            #region Podaci Salona
            modelBuilder.Entity<SalonLjepote>().HasData(
                new SalonLjepote()
                {
                    SalonLjepoteId = 1000,
                    NazivSalona = "e Salon ljepote",
                    Adresa = " Maršala Tita 294, Mostar 88000",
                    Email = "esalonljepote@gmail.com",
                    Telefon = " 036 503-100",
                    RadnoVrijemeId= 7001,
                    AdministratorId= 1007,
                });
            #endregion

            #region Dodavanje Administratora
            modelBuilder.Entity<Administrator>().HasData(
                new Administrator()
                {
                    AdministratorId = 1007,
                    DatumZaposlenja = new DateTime(2020,04,04),
                    OpisPosla = "dodati slobodne termine za usluge, dodavati novosti, dodavati slike u galeriju, moći će pregledati spisak naručenih klijenata, te dodavati proizvode za kupovinu, upravljanje zaposlenicima",
                    KorisnikId = 1001,
                });
            #endregion

            var galerijaSlika = Convert.FromBase64String("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");
            #region Dodavanje Galerije
            modelBuilder.Entity<Galerija>().HasData(
                new Galerija()
                {
                    GalerijaId = 3001,
                    Slika=galerijaSlika,
                    AdministratorId= 1007,
                });
            #endregion

            #region Dodavanje Klijenta
            modelBuilder.Entity<Klijenti>().HasData(
               new Klijenti()
               {
                   KlijentId = 4001,
                   KorisnikId = 1002,
               });
            #endregion

            #region Dodavanje Narudzbi
            modelBuilder.Entity<Narudzba>().HasData(
                new Narudzba()
                {
                    NarudzbaId = 3100,
                    ProizvodId = 6010,
                    PlacanjeId = 5011,
                    DatumNarudzbe=new DateTime(2024,04,05),
                    KolicinaProizvoda = 2,
                    IznosNarudzbe =14,
                    KorisnikId = 1002,
                },
                  new Narudzba()
                  {
                      NarudzbaId = 3200,
                      ProizvodId = 6010,
                      PlacanjeId = 5011,
                      DatumNarudzbe = new DateTime(2024,05,05),
                      KolicinaProizvoda=2,
                      IznosNarudzbe=14,
                      KorisnikId = 1002,
                  },
                  new Narudzba()
                  {
                      NarudzbaId = 3300,
                      ProizvodId =6010 ,
                      PlacanjeId = 5011,
                      DatumNarudzbe = new DateTime(2024,05,06),
                      KorisnikId = 1002,
                      KolicinaProizvoda  =2,
                      IznosNarudzbe=14,
                  },
                  new Narudzba()
                  {
                      NarudzbaId = 3400,
                      ProizvodId = 6010,
                      PlacanjeId = 5011,
                      DatumNarudzbe = new DateTime(2024,05,07),
                      KorisnikId = 1002,
                      KolicinaProizvoda = 2,
                      IznosNarudzbe=14
                  });
            #endregion

            #region Dodavanje Novosti

            modelBuilder.Entity<Novosti>().HasData(
                new Novosti()
                {
                    NovostiId = 5001,
                    Naziv = "Uskoro nesto novo",
                    OpisNovisti = "Novi tretman",
                    DatumObjave = new DateTime(2024,12,02),
                    KorisnikId =1001,
                    Aktivna = 1,
                });
            #endregion

            #region Dodavanje Placanja
            modelBuilder.Entity<Placanje>().HasData(
                new Placanje()
                {
                    PlacanjeId = 5011,
                    NacinPlacanja = "Kartica",
                },
                new Placanje()
                {
                    PlacanjeId = 5012,
                    NacinPlacanja = "Kes",
                });
            #endregion

            #region Dodavanje Proizvoda
            modelBuilder.Entity<Proizvod>().HasData(
                new Proizvod()
                {
                    ProizvodId = 6010,
                    NazivProizvoda = "Lak za kosu",
                    Slika =galerijaSlika,
                    Cijena =7,

                });
            #endregion

            #region Dodavanje Radno vrijeme
            modelBuilder.Entity<RadnoVrijeme>().HasData(
                new RadnoVrijeme()
                {
                    RadnoVrijemeId = 7001,
                    RadnoVrijemeOd = DateTime.Parse("08:00"),
                    RadnoVrijemeDo = DateTime.Parse("16:00"),

                    VrijemePauze = TimeSpan.Parse("12:30"),
                    NeradniDani = "Nova godina (1.1, 2.1)",
                    KolektivniOdmor ="1.8-1.9",

                });
            #endregion

            #region Dodavanje Recenzije
            modelBuilder.Entity<Recenzije>().HasData(
                new Recenzije()
                {
                    RecenzijeId = 8100,
                    KorisnikId= 1002,
                    OpisRecenzije="Vrlo dobar",
                    Ocjena=5,
                });
            #endregion

            #region Dodavnje Termini
            modelBuilder.Entity<Termini>().HasData(
                new Termini()
                {
                    TerminId = 6110,
                    KlijentId = 4001,
                    UslugaId= 7111,
                    ZaposleniId= 8112,
                    DatumTermina=new DateTime(2024,05,05),
                    VrijemeTermina=TimeSpan.Parse("09:00")
                },
                 new Termini()
                 {
                     TerminId = 6111,
                     KlijentId = 4001,
                     UslugaId = 7111,
                     ZaposleniId = 8112,
                     DatumTermina = new DateTime(2024, 05, 05),
                     VrijemeTermina = TimeSpan.Parse("10:00")
                 },
                  new Termini()
                  {
                      TerminId = 6112,
                      KlijentId = 4001,
                      UslugaId = 7111,
                      ZaposleniId = 8112,
                      DatumTermina = new DateTime(2024, 05, 05),
                      VrijemeTermina = TimeSpan.Parse("11:00")
                  });
            #endregion

            #region Dodavnje Usluga
            modelBuilder.Entity<Usluga>().HasData(
                new Usluga()
                {
                    UslugaId = 7110,
                    NazivUsluge = "Frizerske - Feniranje",
                    Cijena=10,
                    Trajanje="30 minuta"

                },
                new Usluga()
                {
                    UslugaId = 7111,
                    NazivUsluge = "Frizerske - Sisanje",
                    Cijena = 25,
                    Trajanje = "1 sat"

                },
                new Usluga()
                {
                    UslugaId = 7121,
                    NazivUsluge = "Frizerske - Sisanje",
                    Cijena = 25,
                    Trajanje = "1 sat"

                },
                 new Usluga()
                 {
                     UslugaId = 7112,
                     NazivUsluge = "Kozmeticke - manikir",
                     Cijena = 30,
                     Trajanje = "1 sat"
                 },
                  new Usluga()
                  {
                      UslugaId = 7113,
                      NazivUsluge = "Kozmeticke - pedikir",
                      Cijena = 30,
                      Trajanje = "1 sat"
                  },
                  new Usluga()
                  {
                      UslugaId = 7114,
                      NazivUsluge = "Sminkanje sa umjetnim trepavicama",
                      Cijena = 40,
                      Trajanje = "1 sat"
                  },
                   new Usluga()
                   {
                       UslugaId = 7115,
                       NazivUsluge = "Sminkanje bez umjetnim trepavicama",
                       Cijena = 35,
                       Trajanje = "1 sat"
                   });
            #endregion

            #region Dodavanje Zaposleni
            modelBuilder.Entity<Zaposleni>().HasData(
                new Zaposleni()
                {
                    ZaposleniId = 8111,
                    DatumZaposlenja = new DateTime(2023,05,05),
                    Zanimanje="Sminker",
                    KorisnikId=1003,

                },
                new Zaposleni()
                {
                    ZaposleniId = 8112,
                    DatumZaposlenja = new DateTime(2023, 05, 05),
                    Zanimanje = "Frizer",
                    KorisnikId = 1004,

                },
                new Zaposleni()
                {
                    ZaposleniId = 8113,
                    DatumZaposlenja = new DateTime(2023, 05, 05),
                    Zanimanje = "Kozmeticar",
                    KorisnikId = 1005,
                }
                );
            #endregion

            //OnModelCreatingPartial(modelBuilder);

        }
    }
}
