using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSaljonLjepote.Services.Service
{
    public interface IKorisnikService : ICRUDService<eSalonLjepote.Model.Models.Korisnik, KorisnikSearchRequest, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        //Model.Models.Korisnik Login(string username, string password);

    }
}
