using AutoMapper;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eSalonLjepote.Service.Database;
using Microsoft.EntityFrameworkCore;

namespace eSalonLjepote.Service.Service
{
   
    public class BaseProizvodService<T, TDb, TSearch> : IServiceProizvod<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected ESalonLjepoteContext _context;
        protected IMapper _mapper { get; set; }
        public BaseProizvodService(ESalonLjepoteContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            var respons = new PagedResult<T>();

            query = AddInclude(query, search);

            query = AddFilter(query, search);

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                var list = await query
                   .Skip((int)((search.Page - 1) * search.PageSize))
                   .Take((int)search.PageSize)
                   .ToListAsync();

                respons.Result = _mapper.Map<List<T>>(list);
            }
            else
            {
                var list = await query.ToListAsync();
                respons.Result = _mapper.Map<List<T>>(list);
            }
            respons.Count = query.Count();
            return respons;
        }


        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }
    }
}
