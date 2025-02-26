using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    
    public class GalerijaController : BaseCRUDController<Model.Models.Galerija, BaseSearchObject, GalerijaInsertRequest, GalerijaUpdateRequest>
    {
        public GalerijaController(ILogger<BaseController<Model.Models.Galerija, BaseSearchObject>> logger, IGalerijaService service) : base(logger, service)
    {

    }
}
}
