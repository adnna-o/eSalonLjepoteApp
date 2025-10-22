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
    public class KorpaService : BaseCRUDService<eSalonLjepote.Model.Models.Korpa, eSalonLjepote.Service.Database.Korpa, KorpaSearchObject, KorpaInsertRequest, KorpaUpdateRequest>, IKorpaService
    {
        public KorpaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<eSalonLjepote.Service.Database.Korpa> AddInclude(IQueryable<eSalonLjepote.Service.Database.Korpa> query, KorpaSearchObject? search = null)
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

        
    }
}
