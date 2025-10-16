using eSalonLjepote.Model;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface IServiceProizvod<T, TSearch> where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search=null);
        Task<T>GetById(int id);
    }
}
