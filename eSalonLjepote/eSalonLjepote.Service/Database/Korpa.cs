using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Database
{
    public class Korpa
    {
        public int KorpaId { get; set; }
        public int ProizvodId { get; set; }
        public int KorisnikId { get; set; }
        public int? Kolicina { get; set; }
        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Proizvod Proizvod { get; set; } = null!;
    }
}
