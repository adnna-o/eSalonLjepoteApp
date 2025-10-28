using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Recenzije
{
    public int RecenzijeId { get; set; }

    public int KorisnikId { get; set; }

    public string OpisRecenzije { get; set; } = null!;

    public int? Ocjena { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

}
