using eSalonLjepote.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class KorpaInsertRequest
    {
       // public int KorpaId { get; set; }
        public int ProizvodId { get; set; }
        public int KorisnikId { get; set; }
        public int? Kolicina { get; set; }
    }
}
