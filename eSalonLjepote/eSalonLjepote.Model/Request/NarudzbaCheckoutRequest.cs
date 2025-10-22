using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class NarudzbaCheckoutRequest
    {
        public int KorisnikId { get; set; }
        public int ProizvodId { get; set; }

        public string? Adresa { get; set; }
        public DateTime? DatumNarudzbe { get; set; }
        public string? Napomena { get; set; }
        public List<NarudzbaCheckoutStavkaRequest> Stavke { get; set; } = new();
    }
}
