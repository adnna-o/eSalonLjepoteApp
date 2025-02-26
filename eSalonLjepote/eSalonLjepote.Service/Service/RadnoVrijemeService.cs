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

namespace eSalonLjepote.Service.Service
{
    public class RadnoVrijemeService : BaseCRUDService<eSalonLjepote.Model.Models.RadnoVrijeme, eSalonLjepote.Service.Database.RadnoVrijeme, BaseSearchObject, RadnoVrijemeInsertRequest, RadnoVrijemeUpdateRequest>, IRadnoVrijemeService
    {
        public RadnoVrijemeService(ESalonLjepoteContext context, IMapper mapper)
            : base(context, mapper)
        {
        }
    
    }
}
