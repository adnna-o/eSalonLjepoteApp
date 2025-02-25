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
    
        public class AdministratorService : BaseCRUDService<eSalonLjepote.Model.Models.Administrator, eSalonLjepote.Service.Database.Administrator, AdministratorSearchRequest, AdministratorInsterRequest, AdministratorUpdateRequest>, IAdministratorService
        {
            public AdministratorService(ESalonLjepoteContext context, IMapper mapper)
                : base(context, mapper)
            {
            }

        public override IQueryable<eSalonLjepote.Service.Database.Administrator> AddInclude(IQueryable<eSalonLjepote.Service.Database.Administrator> query, AdministratorSearchRequest? search = null)
        {
            if (search?.IsKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }

    }
}
