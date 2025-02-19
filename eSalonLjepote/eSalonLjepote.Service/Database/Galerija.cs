using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Galerija
{
    public int GalerijaId { get; set; }

    public byte[]? Slika { get; set; }

    public int AdministratorId { get; set; }

    public virtual Administrator Administrator { get; set; } = null!;
}
