using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Narudzba
    {
        public int NarudzbaId { get; set; }

        public int ProizvodId { get; set; }

        public int KorisnikId { get; set; }

        public int PlacanjeId { get; set; }

        public DateTime DatumNarudzbe { get; set; }

        public int KolicinaProizvoda { get; set; }

        public decimal? IznosNarudzbe { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Placanje Placanje { get; set; } = null!;

        public virtual Proizvod Proizvod { get; set; } = null!;
    }
}
