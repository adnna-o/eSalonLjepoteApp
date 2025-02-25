using eSalonLjepote.Model.Request.SearchRequest;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
 
    public class AdministratorController : BaseCRUDController<Model.Models.Administrator, AdministratorSearchRequest, AdministratorInsterRequest, AdministratorUpdateRequest>
    {
        public AdministratorController(ILogger<BaseController<Model.Models.Administrator, AdministratorSearchRequest>> logger, IAdministratorService service) : base(logger, service)
        {
        }
    }
}
