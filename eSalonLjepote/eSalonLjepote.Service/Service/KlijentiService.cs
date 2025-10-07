using AutoMapper;
using eSaljonLjepote.Services.Service;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Service.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public class KlijentiService : BaseCRUDService<eSalonLjepote.Model.Models.Klijenti, eSalonLjepote.Service.Database.Klijenti, KlijentiSearchRequest, KlijentiInsertRequest, KlijentiUpdateRequest>, IKlijentiService
    {
        public KlijentiService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {}

        public override IQueryable<eSalonLjepote.Service.Database.Klijenti> AddInclude(IQueryable<eSalonLjepote.Service.Database.Klijenti> query, KlijentiSearchRequest? search = null)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }

        public override IQueryable<Database.Klijenti> AddFilter(IQueryable<Database.Klijenti> query, KlijentiSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImeKlijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.ImeKlijenta.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeKlijenta))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Prezime.Contains(search.PrezimeKlijenta.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.UslugaKlijenta))
            {
                string searchUsluga= search.UslugaKlijenta.ToLower();

                filteredQuery = filteredQuery.Where(x => x.Terminis.Any(t=>t.Usluga.NazivUsluge.ToLower()
                .Contains(search.UslugaKlijenta.ToLower())));
            }
           if (!string.IsNullOrWhiteSpace(search?.NarudzbaKlijenta))
            {
                string searchNarudzba = search.NarudzbaKlijenta.ToLower();

                filteredQuery = filteredQuery.Where(x => x.Korisnik.Narudzbas.Any(t => t.Proizvod.NazivProizvoda!.ToLower()
                .Contains(search.NarudzbaKlijenta.ToLower())));
            }
            return filteredQuery;
        }
    }
}
