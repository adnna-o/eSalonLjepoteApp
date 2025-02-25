using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class UslugaInsertRequest
    {
        public string NazivUsluge { get; set; }
        public decimal? Cijena { get; set; }

        public string? Trajanje { get; set; }
    }
}
