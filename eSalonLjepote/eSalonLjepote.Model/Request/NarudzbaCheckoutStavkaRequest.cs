using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class NarudzbaCheckoutStavkaRequest
    {
        public int ProizvodId { get; set; }
        public int Kolicina { get; set; }
    }
}
