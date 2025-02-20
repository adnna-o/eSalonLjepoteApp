using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Models;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    public class KorisnikController : BaseCRUDController<Model.Models.Korisnik, KorisnikSearchRequest, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public KorisnikController(ILogger<BaseController<Model.Models.Korisnik, KorisnikSearchRequest>> logger, IKorisnikService service) : base(logger, service)
        {

        }

        //[Authorize(Roles = "Admin")]
        public override Korisnik Insert([FromBody] KorisnikInsertRequest insert)
        {
            return base.Insert(insert);
        }
        /*[HttpPost("login")]
        [AllowAnonymous]
        public Model.Models.Korisnik Login(string username, string password)
        {
            return (_service as IKorisnikService).Login(username, password);
        }*/
        /*[HttpGet("Authenticate")]
        [AllowAnonymous]
        public Korisnik Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];

            string encodedHeader = authorization["Basic ".Length..].Trim();

            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));

            int seperatorIndex = usernamePassword.IndexOf(':');

            return ((IKorisnikService)_service).Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }*/

    }
}
