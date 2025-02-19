using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Recenzije
{
    public int RecenzijeId { get; set; }

    public int KlijentId { get; set; }

    public int ZaposleniId { get; set; }

    public int UslugaId { get; set; }

    public int ProizvodId { get; set; }

    public string OpisRecenzije { get; set; } = null!;

    public int? Ocjena { get; set; }

    public virtual Klijenti Klijent { get; set; } = null!;

    public virtual Usluga Usluga { get; set; } = null!;

    public virtual Zaposleni Zaposleni { get; set; } = null!;
}
