using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class NovostiController : BaseCRUDController<Model.Models.Novosti, NovostiSearchRequest, NovostiInsertRequest, NovostiUpdateRequest>
    {
        public NovostiController(ILogger<BaseController<Model.Models.Novosti, NovostiSearchRequest>> logger, INovostiService service) : base(logger, service)
        {
        }
    }
    }
