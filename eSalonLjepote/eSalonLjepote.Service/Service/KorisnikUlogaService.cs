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
    public class KorisnikUlogaService : BaseCRUDService<eSalonLjepote.Model.Models.KorisnikUloga, eSalonLjepote.Service.Database.KorisnikUloga, BaseSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>, IKorisnikUlogaService
    {
        public KorisnikUlogaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        { }
    }
}
