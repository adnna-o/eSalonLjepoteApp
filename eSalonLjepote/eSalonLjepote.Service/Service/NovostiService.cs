using AutoMapper;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Database;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace eSalonLjepote.Service.Service
{
    public class NovostiService : BaseCRUDService<eSalonLjepote.Model.Models.Novosti, eSalonLjepote.Service.Database.Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiUpdateRequest>, INovostiService
    {
        public NovostiService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<eSalonLjepote.Service.Database.Novosti> AddInclude(IQueryable<eSalonLjepote.Service.Database.Novosti> query, NovostiSearchRequest? search = null)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }

        public override IQueryable<eSalonLjepote.Service.Database.Novosti> AddFilter(IQueryable<eSalonLjepote.Service.Database.Novosti> query, NovostiSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.Naziv.ToLower()));
            }
            

            return filteredQuery;

        }
    }
}
