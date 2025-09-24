using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class TerminiSearchRequest:BaseSearchObject
    {
        public bool isKlijentiIncluded { get; set; }

        public bool isUslugaIncluded { get; set; }

        public bool isZaposleniIncluded { get; set; }

        public DateTime? DatumTermina { get; set; }
        public string? ImeKlijenta { get; set; }
        public string? PrezimeKlijenta { get; set; }

        //public TimeSpan? VrijemeTermina { get; set; }
        public string? NazivUsluge { get; set; }


    }
}
