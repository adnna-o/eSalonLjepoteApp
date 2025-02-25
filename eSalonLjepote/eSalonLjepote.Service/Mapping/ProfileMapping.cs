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

        }
    }
}
