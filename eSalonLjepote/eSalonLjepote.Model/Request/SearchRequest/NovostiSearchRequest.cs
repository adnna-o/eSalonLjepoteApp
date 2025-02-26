using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class NovostiSearchRequest:BaseSearchObject
    {

        public string? Naziv { get; set; }

      //  public DateTime? DatumObjave { get; set; }

        public bool isKorisnikIncluded { get; set; }

       // public int? Aktivna { get; set; }
    }
}
