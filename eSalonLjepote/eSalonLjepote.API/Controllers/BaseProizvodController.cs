using eSalonLjepote.Model;
using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseProizvodController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IServiceProizvod<T, TSearch> _service;
        protected readonly ILogger<BaseProizvodController<T, TSearch>> _logger;

        public BaseProizvodController(ILogger<BaseProizvodController<T, TSearch>> logger, IServiceProizvod<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet]
        public async Task<PagedResult<T>> Get([FromQuery] TSearch search = null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
