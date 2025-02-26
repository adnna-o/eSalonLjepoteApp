using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Models
{
    public class Galerija
    {
        public int GalerijaId { get; set; }

        public byte[]? Slika { get; set; }

        public int AdministratorId { get; set; }

        public virtual Administrator Administrator { get; set; } = null!;
    }
}
