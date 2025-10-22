using AutoMapper;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Database;
using eSaljonLjepote.Services.Service;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public class OcjeneProizvodaService : BaseCRUDService<Model.Models.OcjeneProizvoda, eSalonLjepote.Service.Database.OcjeneProizvoda, OcjeneProizvodaSearchRequest, OcjeneProizvodaInsertRequest, OcjeneProizvodaUpdateRequest>, IOcjeneProizvodaService
    {
        public OcjeneProizvodaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.OcjeneProizvoda> AddInclude(IQueryable<eSalonLjepote.Service.Database.OcjeneProizvoda> query, OcjeneProizvodaSearchRequest? search = null)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            if (search?.isProizvodIncluded == true)
            {
                query = query.Include("Proizvod");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<eSalonLjepote.Service.Database.OcjeneProizvoda> AddFilter(IQueryable<eSalonLjepote.Service.Database.OcjeneProizvoda> query, OcjeneProizvodaSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.Ocjena != null)
            {

                filteredQuery = filteredQuery.Where(x => x.Ocjena == search.Ocjena);
            }
            if (search?.NazivProizvoda != null)
            {

                filteredQuery = filteredQuery.Where(x => x.Proizvod.NazivProizvoda == search.NazivProizvoda);
            }

            return filteredQuery;
        }
    }
}
