using eSalonLjepote.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class NovostiInsertRequest
    {
      

        public string? Naziv { get; set; }

        public string? OpisNovisti { get; set; }

        public DateTime? DatumObjave { get; set; }

        public int KorisnikId { get; set; }

        public int? Aktivna { get; set; }

        
    }
}
