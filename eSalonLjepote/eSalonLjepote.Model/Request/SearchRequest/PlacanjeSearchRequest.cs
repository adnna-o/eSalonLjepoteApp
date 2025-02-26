using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class PlacanjeSearchRequest:BaseSearchObject
    {
        public string NacinPlacanja { get; set; } = null!;

    }
}
