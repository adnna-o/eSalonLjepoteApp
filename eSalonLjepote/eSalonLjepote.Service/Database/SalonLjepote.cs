using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class SalonLjepote
{
    public int SalonLjepoteId { get; set; }

    public string NazivSalona { get; set; } = null!;

    public string Adresa { get; set; } = null!;

    public string Telefon { get; set; } = null!;

    public string Email { get; set; } = null!;

    public int RadnoVrijemeId { get; set; }

    public int AdministratorId { get; set; }

    public virtual Administrator Administrator { get; set; } = null!;

    public virtual RadnoVrijeme RadnoVrijeme { get; set; } = null!;
}
