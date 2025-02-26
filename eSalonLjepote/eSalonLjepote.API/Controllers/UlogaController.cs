using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class UlogaController : BaseCRUDController<Model.Models.Uloga, UlogaSearchRequest, UlogaInsertRequest, UlogaUpdateRequest>
    {
        public UlogaController(ILogger<BaseController<Model.Models.Uloga, UlogaSearchRequest>> logger, IUlogaService service) : base(logger, service)
        {

        }
    }
}
