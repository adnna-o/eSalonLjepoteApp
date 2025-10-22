using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Database
{
    public class OcjeneProizvoda
    {
        public int OcjeneProizvodaId { get; set; }
        public int? Ocjena { get; set; }
        public string? Opis { get; set; }
        public int? ProizvodId { get; set; }
        public int? KorisnikId { get; set; }
        public virtual Proizvod Proizvod { get; set; }
        public virtual Korisnik Korisnik { get; set; }
    }
}
