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
    public class ProizvodiService : BaseCRUDService<Model.Models.Proizvod, eSalonLjepote.Service.Database.Proizvod, ProizvodSearchRequest, ProizvodInsertRequest, ProizvodUpdateRequest>, IProizvodService
    {
        public ProizvodiService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.Proizvod> AddFilter(IQueryable<eSalonLjepote.Service.Database.Proizvod> query, ProizvodSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NazivProizvoda))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivProizvoda.Contains(search.NazivProizvoda.ToLower()));
            }

            return filteredQuery;
        }
    }
}
