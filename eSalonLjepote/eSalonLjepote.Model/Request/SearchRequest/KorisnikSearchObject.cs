using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class KorisnikSearchObject:BaseSearchObject
    {
        public string? ImeKorisnika { get; set; }   
        public string? PrezimeKorisnika { get; set; }
        public bool? IsUlogeIncluded {  get; set; }
        public string? KorisnickoIme { get; set; }
    }
}
