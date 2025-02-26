using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class ZaposleniInsertRequest
    {
        public DateTime? DatumZaposlenja { get; set; }

        public string? Zanimanje { get; set; }

        public int KorisnikId { get; set; }
    }
}
