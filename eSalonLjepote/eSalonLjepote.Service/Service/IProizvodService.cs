using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface IProizvodService : ICRUDProizvodiService<Model.Models.Proizvod, ProizvodSearchRequest, ProizvodInsertRequest, ProizvodUpdateRequest>
    {

        List<Model.Models.Proizvod> GetPreporuceniProizvodi(int id);
        List<Model.Models.Proizvod> GetRecommendedProizvods();

    }

}
