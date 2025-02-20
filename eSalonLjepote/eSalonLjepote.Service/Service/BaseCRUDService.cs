using AutoMapper;
using eSaljonLjepote.Services.Database;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Service.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSaljonLjepote.Services.Service
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate>
        where T : class where TDb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(ESalonLjepoteContext eContext, IMapper mapper) : base(eContext, mapper)
        {
        }

        public virtual T Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();
            TDb entity = _mapper.Map<TDb>(insert);
            set.Add(entity);
            BeforeInsert(insert, entity);
            _context.SaveChanges();
            return _mapper.Map<T>(entity);
        }

        public virtual void BeforeInsert(TInsert insert, TDb entity)
        {

        }


        public virtual T Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();
            var entity = set.Find(id);
            if (entity != null)
            {
                _mapper.Map(update, entity);
            }
            else
            {
                return null;
            }
            _context.SaveChanges();
            return _mapper.Map<T>(entity);
        }
        public virtual T Delete(int id)
        {
            var set = _context.Set<TDb>();
            var entity = set.Find(id);
            if (entity != null)
            {
                var tmp = entity;
                _context.Remove(entity);
                int result = _context.SaveChanges(); 
                Console.WriteLine($"Delete result: {result}"); 
                return _mapper.Map<T>(tmp);
            }
            else
            {
                return null;
            }
        }



    }
}
