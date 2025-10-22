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
               

                if (!string.IsNullOrWhiteSpace(search.KupacImePrezime))
                {
                    filteredQuery = filteredQuery.Where(n =>
                        n.Korisnik.Ime.Contains(search.KupacImePrezime) ||
                        n.Korisnik.Prezime.Contains(search.KupacImePrezime)
                    );
                }

                if (!string.IsNullOrWhiteSpace(search.SadrzajNarudzbe))
                {
                    filteredQuery = filteredQuery.Where(n =>
                        n.Proizvod.NazivProizvoda.Contains(search.SadrzajNarudzbe)
                    );
                }

                if (search.DatumOd.HasValue)
                {
                    filteredQuery = filteredQuery.Where(n => n.DatumNarudzbe.Date >= search.DatumOd.Value.Date);
                }

                if (search.DatumDo.HasValue)
                {
                    filteredQuery = filteredQuery.Where(n => n.DatumNarudzbe.Date <= search.DatumDo.Value.Date);
                }

                if (search.IznosOd.HasValue)
                {
                    filteredQuery = filteredQuery.Where(n => n.IznosNarudzbe >= search.IznosOd.Value);
                }

                if (search.IznosDo.HasValue)
                {
                    filteredQuery = filteredQuery.Where(n => n.IznosNarudzbe <= search.IznosDo.Value);
                }

                // Ovi postojeći filteri se mogu zadržati ako su potrebni
                if (search.DatumNarudzbe != default(DateTime))
                {
                    filteredQuery = filteredQuery.Where(n => n.DatumNarudzbe.Date == search.DatumNarudzbe.Date);
                }

                if (search.KolicinaProizvoda != 0)
                {
                    filteredQuery = filteredQuery.Where(n => n.KolicinaProizvoda == search.KolicinaProizvoda);
                }

                if (search.IznosNarudzbe.HasValue)
                {
                    filteredQuery = filteredQuery.Where(n => n.IznosNarudzbe == search.IznosNarudzbe);
                }

            }
            return filteredQuery;
        }

        public async Task<Model.Models.Narudzba> Checkout(NarudzbaCheckoutRequest req)
        {
            if (req == null || req.KorisnikId <= 0 || req.Stavke == null || req.Stavke.Count == 0)
                throw new ArgumentException("Prazna ili neispravna narudžba.");

            var strategy = _context.Database.CreateExecutionStrategy();

            return await strategy.ExecuteAsync<Model.Models.Narudzba>(async () =>
            {
                await using var tx = await _context.Database.BeginTransactionAsync();
                try
                {
                    var nar = new Database.Narudzba
                    {
                        DatumNarudzbe = req.DatumNarudzbe ?? DateTime.Now,
                        KorisnikId = req.KorisnikId,
                        ProizvodId=req.ProizvodId,
                    };

                    _context.Narudzbas.Add(nar);
                    await _context.SaveChangesAsync();

                   

                    await _context.SaveChangesAsync();
                    await tx.CommitAsync();


                    return _mapper.Map<Model.Models.Narudzba>(nar);
                }
                catch
                {
                    await tx.RollbackAsync();
                    throw;
                }
            });
        }

        public async Task<int> CheckoutFromCart(int korisnikId,int proizvodId, string? paymentId = null, DateTime? datumNarudzbe = null)
        {
            var strategy = _context.Database.CreateExecutionStrategy();

            return await strategy.ExecuteAsync<int>(async () =>
            {
                await using var tx = await _context.Database.BeginTransactionAsync();
                try
                {
                    var stavkeKorpe = await _context.Korpas
                        .Where(k => k.KorisnikId == korisnikId)
                        .ToListAsync();

                    if (!stavkeKorpe.Any())
                        throw new InvalidOperationException("Korpa je prazna.");

                    var narudzba = new Narudzba
                    {
                        KorisnikId = korisnikId ,
                        DatumNarudzbe = datumNarudzbe ?? DateTime.Now,
                        ProizvodId=proizvodId,
                        PaymentId = paymentId

                    };

                    _context.Narudzbas.Add(narudzba);
                    await _context.SaveChangesAsync();

                    _context.Korpas.RemoveRange(stavkeKorpe);
                    await _context.SaveChangesAsync();

                    await tx.CommitAsync();
                    return narudzba.NarudzbaId;
                }
                catch
                {
                    await tx.RollbackAsync();
                    throw;
                }
            });
        }


    }
}
