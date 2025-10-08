using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSalonLjepote.Model.Request.SearchRequest
{
    public class NarudzbaSearchRequest:BaseSearchObject
    {

        public bool isProizvodIncluded {  get; set; }

        public bool isKorisnikIncluded { get; set; }


        public bool isPlacanjeIncluded { get; set; }

        public DateTime DatumNarudzbe { get; set; }

        public int KolicinaProizvoda { get; set; }

        public decimal? IznosNarudzbe { get; set; }

       // public int? NarudzbaId { get; set; }            // Broj narudžbe
        public string? KupacImePrezime { get; set; }    // Kupac
        public string? SadrzajNarudzbe { get; set; }    // Proizvod (naziv)
        public DateTime? DatumOd { get; set; }          // Period od
        public DateTime? DatumDo { get; set; }          // Period do
        public decimal? IznosOd { get; set; }           // Iznos od
        public decimal? IznosDo { get; set; }
    }
}
