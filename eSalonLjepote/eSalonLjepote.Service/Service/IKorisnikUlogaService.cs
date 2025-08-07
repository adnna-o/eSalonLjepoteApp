using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eSalonLjepote.Model.Request.SearchRequest;

namespace eSalonLjepote.Service.Service
{
    public interface IKorisnikUlogaService : ICRUDService<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>
    {

    }
}
