using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class OcjeneProizvodaSearchRequest:BaseSearchObject
    {
        public string? NazivProizvoda {  get; set; }
        public int? Ocjena { get; set; }
        public bool isKorisnikIncluded { get; set; }
        public bool isProizvodIncluded { get; set; }
    }
}
