using AutoMapper;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSaljonLjepote.Services.Mapping
{
    public class ProfileMapping : Profile
    {
        public ProfileMapping()
        {

            CreateMap<eSalonLjepote.Service.Database.Korisnik, eSalonLjepote.Model.Models.Korisnik>();
            CreateMap<KorisnikSearchRequest, eSalonLjepote.Service.Database.Korisnik>();
            CreateMap<KorisnikInsertRequest, eSalonLjepote.Service.Database.Korisnik>();
            CreateMap<KorisnikUpdateRequest, eSalonLjepote.Service.Database.Korisnik>();

            CreateMap<eSalonLjepote.Service.Database.Administrator, eSalonLjepote.Model.Models.Administrator>();
            CreateMap<AdministratorSearchRequest, eSalonLjepote.Service.Database.Administrator>();
            CreateMap<AdministratorInsterRequest, eSalonLjepote.Service.Database.Administrator>();
            CreateMap<AdministratorUpdateRequest, eSalonLjepote.Service.Database.Administrator>();

            CreateMap<eSalonLjepote.Service.Database.Usluga, eSalonLjepote.Model.Models.Usluga>();
            CreateMap<UslugaSearchRequest, eSalonLjepote.Service.Database.Usluga>();
            CreateMap<UslugaInsertRequest, eSalonLjepote.Service.Database.Usluga>();
            CreateMap<UslugaUpdateRequest, eSalonLjepote.Service.Database.Usluga>();

            CreateMap<eSalonLjepote.Service.Database.Zaposleni, eSalonLjepote.Model.Models.Zaposleni>();
            CreateMap<ZaposleniSearchRequest, eSalonLjepote.Service.Database.Zaposleni>();
            CreateMap<ZaposleniInsertRequest, eSalonLjepote.Service.Database.Zaposleni>();
            CreateMap<ZaposleniUpdateRequest, eSalonLjepote.Service.Database.Zaposleni>();

            CreateMap<eSalonLjepote.Service.Database.Uloga, eSalonLjepote.Model.Models.Uloga>();
            CreateMap<UlogaSearchRequest, eSalonLjepote.Service.Database.Uloga>();
            CreateMap<UlogaInsertRequest, eSalonLjepote.Service.Database.Uloga>();
            CreateMap<UlogaUpdateRequest, eSalonLjepote.Service.Database.Uloga>();

            CreateMap<eSalonLjepote.Service.Database.Klijenti, eSalonLjepote.Model.Models.Klijenti>();
            CreateMap<KlijentiSearchRequest, eSalonLjepote.Service.Database.Klijenti>();
            CreateMap<KlijentiInsertRequest, eSalonLjepote.Service.Database.Klijenti>();
            CreateMap<KlijentiUpdateRequest, eSalonLjepote.Service.Database.Klijenti>();

            CreateMap<eSalonLjepote.Service.Database.Termini, eSalonLjepote.Model.Models.Termini>();
            CreateMap<TerminiSearchRequest, eSalonLjepote.Service.Database.Termini>();
            CreateMap<TerminiInsertRequest, eSalonLjepote.Service.Database.Termini>();
            CreateMap<TerminiUpdateRequest, eSalonLjepote.Service.Database.Termini>();

            CreateMap<eSalonLjepote.Service.Database.RadnoVrijeme, eSalonLjepote.Model.Models.RadnoVrijeme>();
            CreateMap<BaseSearchObject, eSalonLjepote.Service.Database.RadnoVrijeme>();
            CreateMap<RadnoVrijemeInsertRequest, eSalonLjepote.Service.Database.RadnoVrijeme>();
            CreateMap<RadnoVrijemeUpdateRequest, eSalonLjepote.Service.Database.RadnoVrijeme>();

            CreateMap<eSalonLjepote.Service.Database.SalonLjepote, eSalonLjepote.Model.Models.SalonLjepote>();
            CreateMap<BaseSearchObject, eSalonLjepote.Service.Database.SalonLjepote>();
            CreateMap<SalonLjepoteInsertRequest, eSalonLjepote.Service.Database.SalonLjepote>();
            CreateMap<SalonLjepoteUpdateRequest, eSalonLjepote.Service.Database.SalonLjepote>();

            CreateMap<eSalonLjepote.Service.Database.Proizvod, eSalonLjepote.Model.Models.Proizvod>();
            CreateMap<ProizvodSearchRequest, eSalonLjepote.Service.Database.Proizvod>();
            CreateMap<ProizvodInsertRequest, eSalonLjepote.Service.Database.Proizvod>();
            CreateMap<ProizvodUpdateRequest, eSalonLjepote.Service.Database.Proizvod>();

            CreateMap<eSalonLjepote.Service.Database.Recenzije, eSalonLjepote.Model.Models.Recenzije>();
            CreateMap<RecenzijeSearchRequest, eSalonLjepote.Service.Database.Recenzije>();
            CreateMap<RecenzijeInsertRequest, eSalonLjepote.Service.Database.Recenzije>();
            CreateMap<RecenzijeUpdateRequest, eSalonLjepote.Service.Database.Recenzije>();

            CreateMap<eSalonLjepote.Service.Database.Placanje, eSalonLjepote.Model.Models.Placanje>();
            CreateMap<PlacanjeSearchRequest, eSalonLjepote.Service.Database.Placanje>();
            CreateMap<PlacanjeInsertRequest, eSalonLjepote.Service.Database.Placanje>();
            CreateMap<PlacanjeUpdateRequest, eSalonLjepote.Service.Database.Placanje>();

            CreateMap<eSalonLjepote.Service.Database.Galerija, eSalonLjepote.Model.Models.Galerija>();
            CreateMap<BaseSearchObject, eSalonLjepote.Service.Database.Galerija>();
            CreateMap<GalerijaInsertRequest, eSalonLjepote.Service.Database.Galerija>();
            CreateMap<GalerijaUpdateRequest, eSalonLjepote.Service.Database.Galerija>();

            CreateMap<eSalonLjepote.Service.Database.Novosti, eSalonLjepote.Model.Models.Novosti>();
            CreateMap<NovostiSearchRequest, eSalonLjepote.Service.Database.Novosti>();
            CreateMap<NovostiInsertRequest, eSalonLjepote.Service.Database.Novosti>();
            CreateMap<NovostiUpdateRequest, eSalonLjepote.Service.Database.Novosti>();

            CreateMap<eSalonLjepote.Service.Database.KorisnikUloga, eSalonLjepote.Model.Models.KorisnikUloga>();
            CreateMap<BaseSearchObject, eSalonLjepote.Service.Database.KorisnikUloga>();
            CreateMap<KorisnikUlogaInsertRequest, eSalonLjepote.Service.Database.KorisnikUloga>();
            CreateMap<KorisnikUlogaUpdateRequest, eSalonLjepote.Service.Database.KorisnikUloga>();

            CreateMap<eSalonLjepote.Service.Database.Narudzba, eSalonLjepote.Model.Models.Narudzba>();
            CreateMap<NarudzbaSearchRequest, eSalonLjepote.Service.Database.Narudzba>();
            CreateMap<NarudzbaInsertRequest, eSalonLjepote.Service.Database.Narudzba>();
            CreateMap<NarudzbaUpdateRequest, eSalonLjepote.Service.Database.Narudzba>();

        }
    }
}
