using AutoMapper;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Service.Database;
using eSaljonLjepote.Services.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace eSalonLjepote.Service.Service
{
    public class ZaposleniService : BaseCRUDService<Model.Models.Zaposleni, eSalonLjepote.Service.Database.Zaposleni, ZaposleniSearchRequest, ZaposleniInsertRequest, ZaposleniUpdateRequest>,IZaposleniService
    {
        public ZaposleniService(ESalonLjepoteContext context, IMapper mapper)
             : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.Zaposleni> AddInclude(IQueryable<eSalonLjepote.Service.Database.Zaposleni> query, ZaposleniSearchRequest? search = null)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<eSalonLjepote.Service.Database.Zaposleni> AddFilter(IQueryable<eSalonLjepote.Service.Database.Zaposleni> query, ZaposleniSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Zanimanje))
            {
                filteredQuery = filteredQuery.Where(x => x.Zanimanje.Contains(search.Zanimanje.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.ImeZaposlenika))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.ImeZaposlenika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeZaposlenika))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Prezime.Contains(search.PrezimeZaposlenika.ToLower()));
            }
            return filteredQuery;
        }
        }
}
