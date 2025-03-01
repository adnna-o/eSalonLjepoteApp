using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class NarudzbaInsertRequest
    {
        public int ProizvodId { get; set; }

        public int KorisnikId { get; set; }

        public int PlacanjeId { get; set; }

        public DateTime DatumNarudzbe { get; set; }

        public int KolicinaProizvoda { get; set; }

        public decimal? IznosNarudzbe { get; set; }
    }
}
