using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using eSalonLjepote.Model.Models;

namespace eSalonLjepote.API.Controllers
{
    [Authorize(Roles = "Korisnik")]
    [AllowAnonymous]
    [Route("[controller]")]

    public class KorisnikController : BaseCRUDController<Model.Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public KorisnikController(ILogger<BaseController<Model.Models.Korisnik, KorisnikSearchObject>> logger, IKorisnikService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Admin")]
        [Authorize(Roles = "Korisnik")]
        public override Korisnik Insert([FromBody] KorisnikInsertRequest insert)
        {
            return base.Insert(insert);
        }


        [HttpPost("login")]
        [AllowAnonymous]
        public Model.Models.Korisnik Login(string username, string password)
        {
            return (_service as IKorisnikService).Login(username, password);
        }
        [HttpGet("Authenticate")]
        [AllowAnonymous]
        public Korisnik Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];

            string encodedHeader = authorization["Basic ".Length..].Trim();

            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));

            int seperatorIndex = usernamePassword.IndexOf(':');
            Console.WriteLine(User.Identity.Name);


            return ((IKorisnikService)_service).Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }
       /* [HttpPost("provjeriLozinku")]
        public IActionResult ProvjeriLozinku([FromBody] ProvjeraLozinkeRequest model)
        {
            if ((_service as IKorisnikService).ProvjeriLozinku(model.KorisnikId, model.StaraLozinka))
                return Ok(new { validnaLozinka = true });

            return BadRequest(new { poruka = "Stara lozinka nije tačna" });
        }

        [HttpPost("promeni-lozinku")]
        public IActionResult PromeniLozinku([FromBody] PromeniLozinkuRequest request)
        {
            try
            {
                var result = ((IKorisnikService)_service).PromeniLozinku(request.KorisnikId, request.StaraLozinka, request.NovaLozinka);
                if (result)
                {
                    return Ok("Lozinka je uspešno promenjena.");
                }
                else
                {
                    return BadRequest("Došlo je do greške pri promeni lozinke.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }*/



    }
}
