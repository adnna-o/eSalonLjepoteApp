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
    public class GalerijaService : BaseCRUDService<eSalonLjepote.Model.Models.Galerija, eSalonLjepote.Service.Database.Galerija, BaseSearchObject, GalerijaInsertRequest, GalerijaUpdateRequest>, IGalerijaService
    {
        public GalerijaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        { }
    }
}
