using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class RadnoVrijemeUpdateRequest
    {
        public DateTime RadnoVrijemeOd { get; set; }

        public DateTime RadnoVrijemeDo { get; set; }

        public TimeSpan? VrijemePauze { get; set; }

        public string? NeradniDani { get; set; }

        public string? KolektivniOdmor { get; set; }
    }
}
