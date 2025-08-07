using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class KorisnikUlogaSearchObject:BaseSearchObject
    {
        public string? ImeKorisnika { get; set; }
        public string? PrezimeKorisnika { get; set; }
        public string? NazivUloge { get; set; }

        public string? UlogaKorisnika { get; set; }
        public bool? IsUlogaIncluded {  get; set; } 
    }
}
