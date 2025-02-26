using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Narudzba
{
    public int NarudzbaId { get; set; }

    public int ProizvodId { get; set; }

    public int KorisnikId { get; set; }

    public int PlacanjeId { get; set; }

    public DateTime DatumNarudzbe { get; set; }

    public int KolicinaProizvoda { get; set; }

    public decimal? IznosNarudzbe { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Placanje Placanje { get; set; } = null!;

    public virtual Proizvod Proizvod { get; set; } = null!;

    public virtual ICollection<Klijenti> Klijentis { get; } = new List<Klijenti>();

}
