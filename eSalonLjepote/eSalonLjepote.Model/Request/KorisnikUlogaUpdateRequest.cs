using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class KorisnikUlogaUpdateRequest
    {
        public int UlogaId { get; set; }

        public int KorisnikId { get; set; }

        public DateTime? DatumIzmjene { get; set; }


    }
}
