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
    public class SalonLjepoteService : BaseCRUDService<Model.Models.SalonLjepote, eSalonLjepote.Service.Database.SalonLjepote, SalonLjepoteSearchRequest, SalonLjepoteInsertRequest, SalonLjepoteUpdateRequest>, ISalonLjepoteService
    {
        public SalonLjepoteService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.SalonLjepote> AddInclude(IQueryable<eSalonLjepote.Service.Database.SalonLjepote> query, SalonLjepoteSearchRequest? search = null)
        {
            if (search?.isRadnoVrijemeIncluded == true)
            {
                query = query.Include("RadnoVrijeme");
            }
            return base.AddInclude(query, search);
        }

    }
}
