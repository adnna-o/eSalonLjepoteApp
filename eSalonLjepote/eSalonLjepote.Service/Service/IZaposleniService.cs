﻿using eSaljonLjepote.Services.Service;
using eSalonLjepote.Model.Request;
using eSalonLjepote.Model.Request.SearchRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Service.Service
{
    public interface IZaposleniService:  ICRUDService<Model.Models.Zaposleni,ZaposleniSearchRequest,ZaposleniInsertRequest,ZaposleniUpdateRequest>
    {

    }
}
