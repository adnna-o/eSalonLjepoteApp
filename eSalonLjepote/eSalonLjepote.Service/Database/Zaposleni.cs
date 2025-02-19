﻿using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Zaposleni
{
    public int ZaposleniId { get; set; }

    public DateTime? DatumZaposlenja { get; set; }

    public string? Zanimanje { get; set; }

    public int KorisnikId { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<Recenzije> Recenzijes { get; } = new List<Recenzije>();

    public virtual ICollection<Termini> Terminis { get; } = new List<Termini>();
}
