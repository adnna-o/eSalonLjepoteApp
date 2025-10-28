using System;
using System.Collections.Generic;

namespace eSalonLjepote.Service.Database;

public partial class Korisnik
{
    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string KorisnickoIme { get; set; } = null!;

    public DateTime? DatumRodjenja { get; set; }

    public string? Email { get; set; }

    public string? Telefon { get; set; }

    public string? Spol { get; set; }

    public byte[]? Slika { get; set; }

    public string LozinkaSalt { get; set; } = null!;

    public string LozinkaHash { get; set; } = null!;

    public virtual ICollection<Administrator> Administrators { get; } = new List<Administrator>();

    public virtual ICollection<Klijenti> Klijentis { get; } = new List<Klijenti>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; } = new List<KorisnikUloga>();

    public virtual ICollection<Narudzba> Narudzbas { get; } = new List<Narudzba>();

    public virtual ICollection<Novosti> Novostis { get; } = new List<Novosti>();

    public virtual ICollection<Zaposleni> Zaposlenis { get; } = new List<Zaposleni>();
    public virtual ICollection<Korpa> Korpas { get; } = new List<Korpa>();
    public virtual ICollection<OcjeneProizvoda> OcjeneProizvodas { get; } = new List<OcjeneProizvoda>();
    public virtual ICollection<Recenzije> Recenzijes { get; } = new List<Recenzije>();


}
