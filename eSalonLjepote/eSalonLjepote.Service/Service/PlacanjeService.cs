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

namespace eSalonLjepote.Service.Service
{
    public class PlacanjeService : BaseCRUDService<Model.Models.Placanje, eSalonLjepote.Service.Database.Placanje, PlacanjeSearchRequest, PlacanjeInsertRequest, PlacanjeUpdateRequest>, IPlacanjeService
    {
        public PlacanjeService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.Placanje> AddFilter(IQueryable<eSalonLjepote.Service.Database.Placanje> query, PlacanjeSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NacinPlacanja))
            {
                filteredQuery = filteredQuery.Where(x => x.NacinPlacanja.Contains(search.NacinPlacanja.ToLower()));
            }

            return filteredQuery;
        }
    }
}
