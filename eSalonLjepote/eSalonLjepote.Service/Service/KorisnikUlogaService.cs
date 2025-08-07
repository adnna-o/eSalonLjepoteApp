using AutoMapper;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eSalonLjepote.Service.Database;

namespace eSalonLjepote.Service.Service
{
    public class KorisnikUlogaService : BaseCRUDService<Model.Models.KorisnikUloga, Database.KorisnikUloga, KorisnikUlogaSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>, IKorisnikUlogaService
    {
        public KorisnikUlogaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<Database.KorisnikUloga> AddInclude(IQueryable<Database.KorisnikUloga> query, KorisnikUlogaSearchObject? search = null)
        {
            if (search?.IsUlogaIncluded == true)
            {
                query = query.Include("Uloga");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<Database.KorisnikUloga> AddFilter(IQueryable<Database.KorisnikUloga> query, KorisnikUlogaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImeKorisnika))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.ImeKorisnika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeKorisnika))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Prezime.Contains(search.PrezimeKorisnika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.NazivUloge))
            {
                filteredQuery = filteredQuery.Where(x => x.Uloga.NazivUloge.Contains(search.NazivUloge.ToLower()));
            }

            return filteredQuery;
        }
    }
}
