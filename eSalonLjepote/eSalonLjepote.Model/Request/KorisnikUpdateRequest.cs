using System;
using System.Collections.Generic;
using System.Text;

namespace eSalonLjepote.Model.Request
{
    public class KorisnikUpdateRequest
    {
       // public int KorisnikId { get; set; }

        public string? Ime { get; set; } = null!;

        public string? Prezime { get; set; } = null!;

        public string? KorisnickoIme { get; set; } = null!;

        public DateTime? DatumRodjenja { get; set; }

        public string? Email { get; set; }

        public string? Telefon { get; set; }

        public string? Spol { get; set; }

       // public byte[]? Slika { get; set; }

        public string? Lozinka { get; set; } = null!;

        public string? PotvrdaLozinke { get; set; } = null!;
    }
}
