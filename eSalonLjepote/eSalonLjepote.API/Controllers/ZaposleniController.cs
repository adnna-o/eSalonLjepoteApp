using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class ZaposleniController : BaseCRUDController<Model.Models.Zaposleni, ZaposleniSearchRequest, ZaposleniInsertRequest, ZaposleniUpdateRequest>
    {
        public ZaposleniController(ILogger<BaseController<Model.Models.Zaposleni, ZaposleniSearchRequest>> logger, IZaposleniService service) : base(logger, service)
        {

        }
    } 
}
