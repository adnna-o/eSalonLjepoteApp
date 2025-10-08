using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Model.Models;
using eSalonLjepote.Model;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    
    public class NarudzbaController : BaseCRUDController<Model.Models.Narudzba, NarudzbaSearchRequest, NarudzbaInsertRequest, NarudzbaUpdateRequest>
    {
        public NarudzbaController(ILogger<BaseController<Model.Models.Narudzba, NarudzbaSearchRequest>> logger, INarudzbaService service) : base(logger, service)
        {

        }
        [HttpGet("Izvjestaj")]
        public async Task<PagedResult<eSalonLjepote.Model.Models.Narudzba>> GetIzvjestaj([FromQuery] NarudzbaSearchRequest? search = null)
        {
            return await _service.Get(search);
        }


    }
}
