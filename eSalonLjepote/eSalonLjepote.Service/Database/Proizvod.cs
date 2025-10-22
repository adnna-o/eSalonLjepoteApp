using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Proizvod
{
    public int ProizvodId { get; set; }

    public string? NazivProizvoda { get; set; }

    public byte[]? Slika { get; set; }

    public decimal Cijena { get; set; }

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();
    public virtual ICollection<OcjeneProizvoda> OcjeneProizvodas { get; } = new List<OcjeneProizvoda>();

}
