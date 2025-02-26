using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class RecenzijeSearchRequest:BaseSearchObject
    {
        public int? Ocjena { get; set; }
        public bool isZaposleniIncluded { get; set; }
        public bool isUslugaIncluded { get; set; }
        public bool isProizvodIncluded { get; set; }
    }
}
