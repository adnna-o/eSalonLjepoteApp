using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Zaposleni
    {
        public int ZaposleniId { get; set; }

        public DateTime? DatumZaposlenja { get; set; }

        public string? Zanimanje { get; set; }

        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;
    }
}
