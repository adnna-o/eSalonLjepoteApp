using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    
    public class TerminiController : BaseCRUDController<Model.Models.Termini, TerminiSearchRequest, TerminiInsertRequest, TerminiUpdateRequest>
    {
        public TerminiController(ILogger<BaseController<Model.Models.Termini, TerminiSearchRequest>> logger, ITerminiService service) : base(logger, service)
        {
        }
    }
}
