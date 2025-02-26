using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class SalonLjepoteSearchRequest:BaseSearchObject
    {
        public bool isRadnoVrijemeIncluded { get; set; }
    }
}
