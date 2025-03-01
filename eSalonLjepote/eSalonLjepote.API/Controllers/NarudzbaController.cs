using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    
    public class NarudzbaController : BaseCRUDController<Model.Models.Narudzba, NarudzbaSearchRequest, NarudzbaInsertRequest, NarudzbaUpdateRequest>
    {
        public NarudzbaController(ILogger<BaseController<Model.Models.Narudzba, NarudzbaSearchRequest>> logger, INarudzbaService service) : base(logger, service)
        {

        }
    }
}
