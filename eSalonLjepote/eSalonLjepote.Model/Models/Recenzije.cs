using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Recenzije
    {
        public int RecenzijeId { get; set; }

        public int KorisnikId { get; set; }

        public string OpisRecenzije { get; set; } = null!;

        public int? Ocjena { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;


    }
}
