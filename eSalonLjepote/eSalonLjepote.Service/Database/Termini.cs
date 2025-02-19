using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Termini
{
    public int TerminId { get; set; }

    public int KlijentId { get; set; }

    public int UslugaId { get; set; }

    public int ZaposleniId { get; set; }

    public DateTime DatumTermina { get; set; }

    public TimeSpan VrijemeTermina { get; set; }

    public virtual Klijenti Klijent { get; set; } = null!;

    public virtual Usluga Usluga { get; set; } = null!;

    public virtual Zaposleni Zaposleni { get; set; } = null!;
}
