using eSalonLjepote.Service.Service;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eSalonLjepote.API.Controllers
{
    [Route("[controller]")]
   
    public class BaseCRUDProizvodController<T, TSearch, TInsert, TUpdate> : BaseProizvodController<T, TSearch> where T : class where TSearch : class
    {
        protected new readonly ICRUDProizvodiService<T, TSearch, TInsert, TUpdate> _service;
        protected readonly ILogger<BaseProizvodController<T, TSearch>> _logger;

        public BaseCRUDProizvodController(ILogger<BaseProizvodController<T, TSearch>> logger, ICRUDProizvodiService<T, TSearch, TInsert, TUpdate> service)
            : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpPost]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
        {
            return await _service.Insert(insert);
        }
        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate update)
        {
            return await _service.Update(id, update);
        }
        [HttpDelete("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            return await _service.Delete(id);
        }

    }
}
