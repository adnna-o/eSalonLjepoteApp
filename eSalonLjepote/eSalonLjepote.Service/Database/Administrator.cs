using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Administrator
{
    public int AdministratorId { get; set; }

    public DateTime? DatumZaposlenja { get; set; }

    public string? OpisPosla { get; set; }

    public int KorisnikId { get; set; }

    public virtual ICollection<Galerija> Galerijas { get; } = new List<Galerija>();

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<SalonLjepote> SalonLjepotes { get; } = new List<SalonLjepote>();
}
