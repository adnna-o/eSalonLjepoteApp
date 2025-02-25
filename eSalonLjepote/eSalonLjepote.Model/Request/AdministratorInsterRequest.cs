using eSalonLjepote.Model.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class AdministratorInsterRequest
    {
        public DateTime? DatumZaposlenja { get; set; }

        public string? OpisPosla { get; set; }

        public int KorisnikId { get; set; }

        // public virtual ICollection<Galerija> Galerijas { get; } = new List<Galerija>();

        //public virtual Korisnik Korisnik { get; set; } = null!;
    }
}
