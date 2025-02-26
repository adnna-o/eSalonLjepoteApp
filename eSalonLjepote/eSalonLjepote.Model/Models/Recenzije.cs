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

        public int KlijentId { get; set; }

        public int ZaposleniId { get; set; }

        public int UslugaId { get; set; }

        public int ProizvodId { get; set; }

        public string OpisRecenzije { get; set; } = null!;

        public int? Ocjena { get; set; }

        public virtual Klijenti Klijent { get; set; } = null!;

        public virtual Usluga Usluga { get; set; } = null!;

        public virtual Zaposleni Zaposleni { get; set; } = null!;

        public virtual Proizvod Proizvod { get; set; } = null!;

    }
}
