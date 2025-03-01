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
    public class NarudzbaService : BaseCRUDService<eSalonLjepote.Model.Models.Narudzba, eSalonLjepote.Service.Database.Narudzba, NarudzbaSearchRequest, NarudzbaInsertRequest, NarudzbaUpdateRequest>, INarudzbaService
    {
        public NarudzbaService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }

        public override IQueryable<eSalonLjepote.Service.Database.Narudzba> AddInclude(IQueryable<eSalonLjepote.Service.Database.Narudzba> query, NarudzbaSearchRequest? search = null)
        {
            if (search?.isPlacanjeIncluded == true)
            {
                query = query.Include("Placanje");
            }
            if (search?.isProizvodIncluded == true)
            {
                query = query.Include("Proizvod");
            }
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }

            return base.AddInclude(query, search);
        }
        public override IQueryable<eSalonLjepote.Service.Database.Narudzba> AddFilter(IQueryable<eSalonLjepote.Service.Database.Narudzba> query, NarudzbaSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            if (search != null)
            {
                // Filtriranje prema Datumu Narudžbe (ako je datum unesen)
                if (search.DatumNarudzbe != default(DateTime))
                {
                    filteredQuery = filteredQuery.Where(n => n.DatumNarudzbe.Date == search.DatumNarudzbe.Date);
                }

                // Filtriranje prema Količini Proizvoda (ako je količina uneta)
                if (search.KolicinaProizvoda != 0)
                {
                    filteredQuery = filteredQuery.Where(n => n.KolicinaProizvoda == search.KolicinaProizvoda);
                }

                // Filtriranje prema Iznosu Narudžbe (ako je iznos unesen)
                if (search.IznosNarudzbe != null)
                {
                    filteredQuery = filteredQuery.Where(n => n.IznosNarudzbe == search.IznosNarudzbe);
                }
            }
            return filteredQuery;
        }

    }
}
