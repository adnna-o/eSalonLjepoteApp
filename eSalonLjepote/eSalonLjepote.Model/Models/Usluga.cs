using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Usluga
    {
        public int UslugaId { get; set; }

        public string NazivUsluge { get; set; } = null!;

        public decimal? Cijena { get; set; }

        public string? Trajanje { get; set; }
    }
}
