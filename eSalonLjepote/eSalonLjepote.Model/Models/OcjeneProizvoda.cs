using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class OcjeneProizvoda
    {
        public int OcjeneProizvodaId { get; set; }
        public int? Ocjena {  get; set; }   
        public string? Opis { get; set; }
        public int? ProizvodId { get;set; }
        public int? KorisnikId { get; set; }
       

    }
}
