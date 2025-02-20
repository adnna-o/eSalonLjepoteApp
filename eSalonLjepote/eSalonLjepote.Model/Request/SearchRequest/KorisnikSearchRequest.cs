using System;
using System.Collections.Generic;
using System.Text;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class KorisnikSearchRequest:BaseSearchObject
    {
        public String? ImeKorisnika { get; set; }
        public String?PrezimeKorisnika { get; set; }
        public String? KorisnickoIme {  get; set; }
        public bool? IsUlogeIncluded {  get; set; }
    }
}
