using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface IKorisnikUlogaService : ICRUDService<Model.Models.KorisnikUloga, BaseSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>
    {}
}
