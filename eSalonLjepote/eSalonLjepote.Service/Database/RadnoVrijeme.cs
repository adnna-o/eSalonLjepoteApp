using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class RadnoVrijeme
{
    public int RadnoVrijemeId { get; set; }

    public DateTime RadnoVrijemeOd { get; set; }

    public DateTime RadnoVrijemeDo { get; set; }

    public TimeSpan? VrijemePauze { get; set; }

    public string? NeradniDani { get; set; }

    public string? KolektivniOdmor { get; set; }

    public virtual ICollection<SalonLjepote> SalonLjepotes { get; } = new List<SalonLjepote>();
}
