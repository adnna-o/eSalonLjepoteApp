using System;
using System.Collections.Generic;
using System.Text;

namespace eSalonLjepote.Model.Models
{
    public class Korisnik
    {
        public int KorisnikId { get; set; }

        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public string KorisnickoIme { get; set; } = null!;

        public DateTime? DatumRodjenja { get; set; }

        public string? Email { get; set; }

        public string? Telefon { get; set; }

        public string? Spol { get; set; }

        public byte[]? Slika { get; set; }

        public string LozinkaSalt { get; set; } = null!;

        public string LozinkaHash { get; set; } = null!;
        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

         public virtual ICollection<Narudzba> Narudzbas { get; set; } = new List<Narudzba>();
        public virtual ICollection<Recenzije> Recenzijes { get; set; } = new List<Recenzije>();

        /* public virtual ICollection<Administrator> Administrators { get; set; } = new List<Administrator>();

         public virtual ICollection<Klijenti> Klijentis { get; set; } = new List<Klijenti>();

         public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();


         public virtual ICollection<Novosti> Novostis { get; set; } = new List<Novosti>();

         public virtual ICollection<Zaposleni> Zaposlenis { get; set; } = new List<Zaposleni>();*/
    }
}
