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
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using Microsoft.ML.Data;

namespace eSalonLjepote.Service.Service
{
    public class ProizvodiService : BaseCRUDProizvodService<Model.Models.Proizvod, eSalonLjepote.Service.Database.Proizvod, ProizvodSearchRequest, ProizvodInsertRequest, ProizvodUpdateRequest>, IProizvodService
    {

        public ProizvodiService(ESalonLjepoteContext context, IMapper mapper)
             : base(context, mapper)
        {
        }
        public override IQueryable<eSalonLjepote.Service.Database.Proizvod> AddFilter(IQueryable<eSalonLjepote.Service.Database.Proizvod> query, ProizvodSearchRequest? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.NazivProizvoda))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivProizvoda.Contains(search.NazivProizvoda.ToLower()));
            }

            return filteredQuery;
        }

        public List<Model.Models.Proizvod> GetPreporuceniProizvodi(int id)
        {
            if (mlContext == null)
            {
                lock (isLocked)
                {
                    if (mlContext == null)
                    {
                        mlContext = new MLContext();
                        var tmpData = _context.Proizvods.Include(o => o.OcjeneProizvodas).ToList();

                        if (!tmpData.Any())
                        {
                            throw new InvalidOperationException("No doktor found in the database.");
                        }

                        var data = new List<DoktorEntry>();

                        foreach (var x in tmpData)
                        {
                            if (x.OcjeneProizvodas.Count > 1)
                            {
                                var distinctItemId = x.OcjeneProizvodas.Select(y => y.ProizvodId).Distinct().ToList();

                                distinctItemId.ForEach(y =>
                                {
                                    var relatedItems = x.OcjeneProizvodas.Where(z => z.OcjeneProizvodaId != y).Select(oi => oi.ProizvodId).Distinct();
                                    foreach (var z in relatedItems)
                                    {
                                        data.Add(new DoktorEntry()
                                        {
                                            ProizvodId = (uint)y,
                                            CoPurchaseProizvodID = (uint)z,
                                            Label = 1.0f
                                        });
                                    }
                                });
                            }
                        }

                        if (data.Count == 0)
                        {
                            throw new InvalidOperationException("No valid data found for training.");
                        }

                        Console.WriteLine($"Data count: {data.Count}");

                        var traindata = mlContext.Data.LoadFromEnumerable(data);

                        MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options
                        {
                            MatrixColumnIndexColumnName = nameof(DoktorEntry.ProizvodId),
                            MatrixRowIndexColumnName = nameof(DoktorEntry.CoPurchaseProizvodID),
                            LabelColumnName = nameof(DoktorEntry.Label),
                            LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                            Alpha = 0.01,
                            Lambda = 0.025,
                            NumberOfIterations = 100,
                            C = 0.00001
                        };

                        var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                        model = est.Fit(traindata);
                    }
                }
            }

            var proizvods = _context.Proizvods.Where(x => x.ProizvodId != id);
            var predictionResult = new List<Tuple<Database.Proizvod, float>>();

            var predictionEngine = mlContext.Model.CreatePredictionEngine<DoktorEntry, Copurchase_prediction>(model);

            foreach (var proizvod in proizvods)
            {
                var prediction = predictionEngine.Predict(
                    new DoktorEntry()
                    {
                        ProizvodId = (uint)id,
                        CoPurchaseProizvodID = (uint)proizvod.ProizvodId,
                    });

                predictionResult.Add(new Tuple<Database.Proizvod, float>(proizvod, prediction.Score));
            }

            var finalResult = predictionResult
                .OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            return _mapper.Map<List<Model.Models.Proizvod>>(finalResult);
        }




        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class DoktorEntry
        {
            [KeyType(count: 3)]
            public uint ProizvodId { get; set; }

            [KeyType(count: 3)]
            public uint CoPurchaseProizvodID { get; set; }

            public float Label { get; set; }
        }



        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<Model.Models.Proizvod> GetRecommendedProizvods()
        {
            var proizvodRatings = _context.OcjeneProizvodas
         .GroupBy(o => o.ProizvodId)
         .Select(g => new
         {
             ProizvodId = g.Key,
             AverageRating = g.Average(o => o.Ocjena.GetValueOrDefault())
         })
         .ToList();

            foreach (var rating in proizvodRatings)
            {
                Console.WriteLine($"DoktorId: {rating.ProizvodId}, AverageRating: {rating.AverageRating}");
            }

            var allDoctors = _context.Proizvods.ToList();

            var recommendedProizvodi = allDoctors
                .Join(proizvodRatings,
                      d => d.ProizvodId,
                      r => r.ProizvodId,
                      (d, r) => new Model.Models.Proizvod
                      {
                          ProizvodId = d.ProizvodId,
                          NazivProizvoda = d.NazivProizvoda,
                          Cijena = d.Cijena,
                          AverageRating = r.AverageRating
                      })
                .OrderByDescending(d => d.AverageRating)
                .Take(5)
                .ToList();

            foreach (var proizvod in recommendedProizvodi)
            {
                Console.WriteLine($"ProizvodId: {proizvod.ProizvodId}, Name: {proizvod.NazivProizvoda}");
            }

            return _mapper.Map<List<Model.Models.Proizvod>>(recommendedProizvodi);
        }



    }
}
