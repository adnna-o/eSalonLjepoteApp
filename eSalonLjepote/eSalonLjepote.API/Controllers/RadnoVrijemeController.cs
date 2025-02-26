using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    
    public class RadnoVrijemeController : BaseCRUDController<Model.Models.RadnoVrijeme, BaseSearchObject, RadnoVrijemeInsertRequest, RadnoVrijemeUpdateRequest>
    {
        public RadnoVrijemeController(ILogger<BaseController<Model.Models.RadnoVrijeme, BaseSearchObject>> logger, IRadnoVrijemeService service) : base(logger, service)
        {

        }
    }
}
