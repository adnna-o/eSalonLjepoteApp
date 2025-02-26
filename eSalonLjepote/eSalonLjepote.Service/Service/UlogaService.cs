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
    public class UlogaService : BaseCRUDService<Model.Models.Uloga, eSalonLjepote.Service.Database.Uloga, UlogaSearchRequest, UlogaInsertRequest, UlogaUpdateRequest>, IUlogaService
    {
        public UlogaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<eSalonLjepote.Service.Database.Uloga> AddFilter(IQueryable<eSalonLjepote.Service.Database.Uloga> query, UlogaSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NazivUloge))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivUloge.Contains(search.NazivUloge.ToLower()));
            }
            return filteredQuery;

        }
    }
}
