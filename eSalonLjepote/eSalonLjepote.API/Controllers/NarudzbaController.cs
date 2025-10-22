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
        protected readonly INarudzbaService _service;
        public NarudzbaController(ILogger<BaseController<Model.Models.Narudzba, NarudzbaSearchRequest>> logger, INarudzbaService service) : base(logger, service)
        {
            _service = service ?? throw new ArgumentNullException(nameof(service));
        }
        [HttpGet("Izvjestaj")]
        public async Task<PagedResult<eSalonLjepote.Model.Models.Narudzba>> GetIzvjestaj([FromQuery] NarudzbaSearchRequest? search = null)
        {
            return await _service.Get(search);
        }

        [HttpPost("checkout")]
        public async Task<ActionResult<int>> Checkout([FromBody] NarudzbaCheckoutRequest request)
        {
            var narudzba = await _service.Checkout(request);
            return Ok(narudzba.NarudzbaId);

        }

        [HttpPost("checkoutFromCart")]
        //[HttpPost("checkout-from-cart")]
        public async Task<ActionResult<int>> CheckoutFromCart([FromBody] CheckoutFromCartRequest req)
        {
            if (req == null || req.KorisnikId <= 0)
                return BadRequest("Neispravan zahtjev.");

            var id = await _service.CheckoutFromCart(req.KorisnikId, req.ProizvodId, req.PaymentId, req.DatumNarudzbe);
            return Ok(id);
        }


    }
}
