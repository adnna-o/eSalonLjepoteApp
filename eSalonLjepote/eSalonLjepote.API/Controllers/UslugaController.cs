using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class UslugaController : BaseCRUDController<Model.Models.Usluga, UslugaSearchRequest, UslugaInsertRequest, UslugaUpdateRequest>
    {
        public UslugaController(ILogger<BaseController<Model.Models.Usluga, UslugaSearchRequest>> logger, IUslugaService service) : base(logger, service)
        {

        }

    }
}
