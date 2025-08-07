using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    public class KorisnikUlogaController : BaseCRUDController<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>
    {
        public KorisnikUlogaController(ILogger<BaseController<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject>> logger, IKorisnikUlogaService service) : base(logger, service)
        {

        }
    }
}
