using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request
{
    public class SalonLjepoteUpdateRequest
    {

        public string NazivSalona { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string Telefon { get; set; } = null!;

        public string Email { get; set; } = null!;

        public int RadnoVrijemeId { get; set; }

        public int AdministratorId { get; set; }

    }
}
