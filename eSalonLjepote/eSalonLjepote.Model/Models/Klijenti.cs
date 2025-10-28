using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Klijenti
    {
        public int KlijentId { get; set; }

        public int KorisnikId { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;


    }
}
