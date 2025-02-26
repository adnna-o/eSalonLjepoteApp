using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    public class KlijentiController : BaseCRUDController<Model.Models.Klijenti, KlijentiSearchRequest, KlijentiInsertRequest, KlijentiUpdateRequest>
    {
        public KlijentiController(ILogger<BaseController<Model.Models.Klijenti, KlijentiSearchRequest>> logger, IKlijentiService service) : base(logger, service)
        {

        }
    }
}
