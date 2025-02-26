using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class RecenzijeUpdateRequest
    {
        public int KlijentId { get; set; }

        public int ZaposleniId { get; set; }

        public int UslugaId { get; set; }

        public int ProizvodId { get; set; }

        public string OpisRecenzije { get; set; } = null!;

        public int? Ocjena { get; set; }
    }
}
