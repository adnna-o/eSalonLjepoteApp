using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class PlacanjeController : BaseCRUDController<Model.Models.Placanje, PlacanjeSearchRequest, PlacanjeInsertRequest, PlacanjeUpdateRequest>
    {
        public PlacanjeController(ILogger<BaseController<Model.Models.Placanje, PlacanjeSearchRequest>> logger, IPlacanjeService service) : base(logger, service)
        {
        }
    }
    }
