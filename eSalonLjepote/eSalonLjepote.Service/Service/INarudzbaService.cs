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
    public interface INarudzbaService : ICRUDService<eSalonLjepote.Model.Models.Narudzba, NarudzbaSearchRequest, NarudzbaInsertRequest, NarudzbaUpdateRequest>
    {
        Task<Model.Models.Narudzba> Checkout(NarudzbaCheckoutRequest request);
        Task<int> CheckoutFromCart(int korisnikId, int proizvodId, string? paymentId = null, DateTime? datumNarudzbe = null);
    }
}
