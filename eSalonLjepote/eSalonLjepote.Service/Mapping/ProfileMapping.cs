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

        }
    }
}
