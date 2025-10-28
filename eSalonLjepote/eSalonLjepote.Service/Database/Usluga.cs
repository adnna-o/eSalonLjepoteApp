using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Usluga
{
    public int UslugaId { get; set; }

    public string NazivUsluge { get; set; } = null!;

    public decimal? Cijena { get; set; }

    public string? Trajanje { get; set; }

    public virtual ICollection<Termini> Terminis { get; } = new List<Termini>();

    public virtual ICollection<Klijenti> Klijentis { get; } = new List<Klijenti>();

}
