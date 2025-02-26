using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSaljonLjepote.Services.Service;
using Microsoft.Extensions.Logging;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
   
    public class SalonLjepoteController : BaseCRUDController<Model.Models.SalonLjepote, SalonLjepoteSearchRequest, SalonLjepoteInsertRequest, SalonLjepoteUpdateRequest>
    {
        public SalonLjepoteController(ILogger<BaseController<Model.Models.SalonLjepote, SalonLjepoteSearchRequest>> logger, ISalonLjepoteService service) : base(logger, service)
        {
        }
    }
}
