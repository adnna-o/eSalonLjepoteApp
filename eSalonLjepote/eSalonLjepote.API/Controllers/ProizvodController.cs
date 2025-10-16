using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using eSalonLjepote.Service.Service;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
   
    public class ProizvodController : BaseCRUDProizvodController<Model.Models.Proizvod, ProizvodSearchRequest, ProizvodInsertRequest, ProizvodUpdateRequest>
    {
        public ProizvodController(ILogger<BaseProizvodController<Model.Models.Proizvod, ProizvodSearchRequest>> logger, IProizvodService service) : base(logger, service)
        {

        }

        [HttpGet("preporuceno/{id}")]
        public List<eSalonLjepote.Model.Models.Proizvod> GetPreporuceniProizvodi(int id)
        {
            return _service.GetPreporuceniProizvodi(id);
        }
        [HttpGet("preporuceni")]
        public ActionResult<List<Model.Models.Proizvod>> GetRecommendedProizvod()
        {
            var recommendedProizvods = _service.GetRecommendedProizvods();
            return Ok(recommendedProizvods);
        }
    }
}
