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
    }
}
