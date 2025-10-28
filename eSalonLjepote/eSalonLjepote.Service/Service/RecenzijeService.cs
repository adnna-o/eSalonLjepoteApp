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
    public class RecenzijeService : BaseCRUDService<Model.Models.Recenzije, eSalonLjepote.Service.Database.Recenzije, RecenzijeSearchRequest, RecenzijeInsertRequest, RecenzijeUpdateRequest>, IRecenzijeService
    {
        public RecenzijeService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.Recenzije> AddInclude(IQueryable<eSalonLjepote.Service.Database.Recenzije> query, RecenzijeSearchRequest? search = null)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<eSalonLjepote.Service.Database.Recenzije> AddFilter(IQueryable<eSalonLjepote.Service.Database.Recenzije> query, RecenzijeSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.Ocjena != null)
            {
               
                filteredQuery = filteredQuery.Where(x => x.Ocjena == search.Ocjena);
            }

            return filteredQuery;
        }
    }
}
