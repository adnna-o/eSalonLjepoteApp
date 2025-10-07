using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class KlijentiSearchRequest:BaseSearchObject
    {
       /// public int KorisnikId { get; set; }
        public bool isKorisnikIncluded { get; set; }
        public string? ImeKlijenta { get; set; }
        public string? PrezimeKlijenta { get; set; }
        public string? UslugaKlijenta { get; set; }
        public string? NarudzbaKlijenta { get; set; }


    }
}
