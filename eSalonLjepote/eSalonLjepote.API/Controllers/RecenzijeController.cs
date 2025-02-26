using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]

    public class RecenzijeController : BaseCRUDController<Model.Models.Recenzije, RecenzijeSearchRequest, RecenzijeInsertRequest, RecenzijeUpdateRequest>
    {
        public RecenzijeController(ILogger<BaseController<Model.Models.Recenzije, RecenzijeSearchRequest>> logger, IRecenzijeService service) : base(logger, service)
        {

        }
    }
    }
