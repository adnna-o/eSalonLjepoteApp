using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class ZaposleniSearchRequest:BaseSearchObject
    {
        public DateTime? DatumZaposlenja { get; set; }

        public string? Zanimanje { get; set; }
        public string? ImeZaposlenika { get; set; }
        public string? PrezimeZaposlenika { get; set; }
        
        public bool? isKorisnikIncluded { get; set; }

    }
}
