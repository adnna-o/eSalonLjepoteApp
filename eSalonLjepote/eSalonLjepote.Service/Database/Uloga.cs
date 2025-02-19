using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Uloga
{
    public int UlogaId { get; set; }

    public string NazivUloge { get; set; } = null!;

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();
}
