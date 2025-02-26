using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class SalonLjepote
    {
        public int SalonLjepoteId { get; set; }

        public string NazivSalona { get; set; } = null!;

        public string Adresa { get; set; } = null!;

        public string Telefon { get; set; } = null!;

        public string Email { get; set; } = null!;

        public int RadnoVrijemeId { get; set; }

        public int AdministratorId { get; set; }

        public virtual Administrator Administrator { get; set; } = null!;

        public virtual RadnoVrijeme RadnoVrijeme { get; set; } = null!;
    }
}
