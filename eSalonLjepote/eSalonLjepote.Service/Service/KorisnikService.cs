using AutoMapper;
using eSaljonLjepote.Services.Database;
using eSaljonLjepote.Services.Service;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using eSalonLjepote.Service.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Services.Service
{
    public class KorisnikService : BaseCRUDService<eSalonLjepote.Model.Models.Korisnik, eSalonLjepote.Service.Database.Korisnik, KorisnikSearchRequest, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
        public override void BeforeInsert(KorisnikInsertRequest insert, eSalonLjepote.Service.Database.Korisnik entity)
        {
            var salt = GenerateSalt();
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = GenerateHash(salt, insert.Lozinka);
            entity.KorisnickoIme = insert.KorisnickoIme;
            if (_context.Korisniks.Any(k => k.KorisnickoIme == insert.KorisnickoIme))
            {
                throw new eSalonLjepote.Model.ConflictException("User with that username already exists");
            }
            //entity.Uloga = insert.UlogaId;
            base.BeforeInsert(insert, entity);
        }
        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];
            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);
            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public override IQueryable<eSalonLjepote.Service.Database.Korisnik> AddInclude(IQueryable<eSalonLjepote.Service.Database.Korisnik> query, KorisnikSearchRequest? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("Uloga");
            }
            return base.AddInclude(query, search);
        }
        public override IQueryable<eSalonLjepote.Service.Database.Korisnik> AddFilter(IQueryable<eSalonLjepote.Service.Database.Korisnik> query, KorisnikSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.ImeKorisnika))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime.Contains(search.ImeKorisnika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.PrezimeKorisnika))
            {
                filteredQuery = filteredQuery.Where(x => x.Prezime.Contains(search.PrezimeKorisnika.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme.Contains(search.KorisnickoIme.ToLower()));
            }

            return filteredQuery;
        }

        public eSalonLjepote.Model.Models.Korisnik Login(string username, string password)
        {
            var entity = _context.Korisniks.Include(x => x.KorisnikUlogas).ThenInclude(y => y.Uloga).FirstOrDefault(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }
            return this._mapper.Map<eSalonLjepote.Model.Models.Korisnik>(entity);
        }

    }
}
