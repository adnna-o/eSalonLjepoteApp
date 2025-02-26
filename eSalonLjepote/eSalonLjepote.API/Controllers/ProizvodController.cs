using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
   
    public class ProizvodController : BaseCRUDController<Model.Models.Proizvod, ProizvodSearchRequest, ProizvodInsertRequest, ProizvodUpdateRequest>
    {
        public ProizvodController(ILogger<BaseController<Model.Models.Proizvod, ProizvodSearchRequest>> logger, IProizvodService service) : base(logger, service)
        {

        }
    }
}
