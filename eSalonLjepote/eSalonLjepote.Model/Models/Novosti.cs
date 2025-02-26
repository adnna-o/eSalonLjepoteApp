using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Novosti
    {
        public int NovostiId { get; set; }

        public string? Naziv { get; set; }

        public string? OpisNovisti { get; set; }

        public DateTime? DatumObjave { get; set; }

        public int KorisnikId { get; set; }

        public int? Aktivna { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;
    }
}
