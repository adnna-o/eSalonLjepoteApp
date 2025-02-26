using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class ProizvodInsertRequest
    {
        public string? NazivProizvoda { get; set; }

        public byte[]? Slika { get; set; }

        public decimal Cijena { get; set; }
    }
}
