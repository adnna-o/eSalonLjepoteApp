using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface ICRUDProizvodiService<T, TSearch, TInsert, TUpdate>: IServiceProizvod<T, TSearch> where TSearch : class
    {
        List<Model.Models.Proizvod> GetPreporuceniProizvodi(int id);
        List<Model.Models.Proizvod> GetRecommendedProizvods();
        Task<T>Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);
        Task<T> Delete(int id);

    }
}
