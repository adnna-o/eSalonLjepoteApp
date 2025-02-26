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
    public class TerminiService : BaseCRUDService<Model.Models.Termini, eSalonLjepote.Service.Database.Termini, TerminiSearchRequest, TerminiInsertRequest, TerminiUpdateRequest>, ITerminiService
    {
        public TerminiService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<eSalonLjepote.Service.Database.Termini> AddInclude(IQueryable<eSalonLjepote.Service.Database.Termini> query, TerminiSearchRequest? search = null)
        {
            if (search?.isZaposleniIncluded == true)
            {
                query = query.Include("Zaposleni");
            }
            if (search?.isKlijentiIncluded == true)
            {
                query = query.Include("Klijent");
            }
            if (search?.isUslugaIncluded == true)
            {
                query = query.Include("Usluga");
            }
            return base.AddInclude(query, search);
        }

        public override IQueryable<eSalonLjepote.Service.Database.Termini> AddFilter(IQueryable<eSalonLjepote.Service.Database.Termini> query, TerminiSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search?.DatumTermina != null)
            {
                query = query.Where(x => x.DatumTermina.Date.Equals(search.DatumTermina));
            }

            return filteredQuery;
        }
    }
    
}
