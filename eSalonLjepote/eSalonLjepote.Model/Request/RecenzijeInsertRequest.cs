using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class RecenzijeInsertRequest
    {
        public int KorisnikId { get; set; }

        public string OpisRecenzije { get; set; } = null!;

        public int? Ocjena { get; set; }
    }
}
