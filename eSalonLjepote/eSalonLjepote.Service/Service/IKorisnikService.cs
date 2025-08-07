using eSaljonLjepote.Services.Service;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface IKorisnikService : ICRUDService<Model.Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        Model.Models.Korisnik Login(string username, string password);
       // bool ProvjeriLozinku(int korisnikId, string staraLozinka);
      //  bool PromeniLozinku(int korisnikId, string staraLozinka, string novaLozinka);
        Task DeleteKorisnikAsync(int korisnikId);

    }
}
