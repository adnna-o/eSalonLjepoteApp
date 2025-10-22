using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    public class OcjeneProizvodaController : BaseCRUDController<Model.Models.OcjeneProizvoda, OcjeneProizvodaSearchRequest, OcjeneProizvodaInsertRequest, OcjeneProizvodaUpdateRequest>
    {
        public OcjeneProizvodaController(ILogger<BaseController<Model.Models.OcjeneProizvoda, OcjeneProizvodaSearchRequest>> logger, IOcjeneProizvodaService service) : base(logger, service)
        {

        }
    }
}
