using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class TerminiUpdateRequest
    {
        public int KlijentId { get; set; }

        public int UslugaId { get; set; }

        public int ZaposleniId { get; set; }

        public DateTime DatumTermina { get; set; }

        public TimeSpan VrijemeTermina { get; set; }

    }
}
