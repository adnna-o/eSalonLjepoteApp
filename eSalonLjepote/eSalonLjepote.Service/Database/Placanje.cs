using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Placanje
{
    public int PlacanjeId { get; set; }

    public string NacinPlacanja { get; set; } = null!;

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();
}
