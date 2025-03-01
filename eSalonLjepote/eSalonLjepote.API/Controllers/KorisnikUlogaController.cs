using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
   
    public class KorisnikUlogaController : BaseCRUDController<Model.Models.KorisnikUloga, BaseSearchObject, KorisnikUlogaInsertRequest, KorisnikUlogaUpdateRequest>
    {
        public KorisnikUlogaController(ILogger<BaseController<Model.Models.KorisnikUloga, BaseSearchObject>> logger, IKorisnikUlogaService service) : base(logger, service)
        {
        }
    }
}
