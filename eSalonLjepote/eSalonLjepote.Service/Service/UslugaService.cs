using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eSalonLjepote.Service.Database;

namespace eSalonLjepote.Service.Service
{
    public class UslugaService : BaseCRUDService<eSalonLjepote.Model.Models.Usluga, eSalonLjepote.Service.Database.Usluga, UslugaSearchRequest, UslugaInsertRequest, UslugaUpdateRequest>, IUslugaService
        
    {
        public UslugaService(ESalonLjepoteContext context, IMapper mapper)
           : base(context, mapper) { }
        public override IQueryable<eSalonLjepote.Service.Database.Usluga> AddFilter(IQueryable<eSalonLjepote.Service.Database.Usluga> query, UslugaSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NazivUsluge))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivUsluge.Contains(search.NazivUsluge.ToLower()));
            }
           
            return filteredQuery;
        }
    }

}
