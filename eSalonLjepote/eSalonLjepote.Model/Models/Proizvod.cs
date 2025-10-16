using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Proizvod
    {
        public int ProizvodId { get; set; }

        public string? NazivProizvoda { get; set; }

        public byte[]? Slika { get; set; }

        public decimal Cijena { get; set; }
        public double? AverageRating { get; set; }

    }
}
