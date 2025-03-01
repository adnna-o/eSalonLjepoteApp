using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class KorisnikUloga
    {
        public int KorisnikUlogaId { get; set; }

        public int UlogaId { get; set; }

        public int KorisnikId { get; set; }

        public DateTime? DatumIzmjene { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Uloga Uloga { get; set; } = null!;
    }
}
