using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Klijenti
{
    public int KlijentId { get; set; }
    
   
    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<Termini> Terminis { get; } = new List<Termini>();
}
