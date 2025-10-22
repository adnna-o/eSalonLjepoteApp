using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    public class KorpaController : BaseCRUDController<Model.Models.Korpa, KorpaSearchObject, KorpaInsertRequest, KorpaUpdateRequest>
    {
        public KorpaController(ILogger<BaseController<Model.Models.Korpa, KorpaSearchObject>> logger, IKorpaService service) : base(logger, service)
        {

        }
    }
}
