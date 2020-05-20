using NapredniBazi.Models;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NapredniBazi.Controllers
{
    public class StatisticsController : Controller
    {
        // GET: Statistics
        public ActionResult Index(int page = 1, int pageSize = 20)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                int count;
                using (var command = new NpgsqlCommand($"SELECT COUNT(*) FROM procent_na_prodazba_po_tv()", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    count = reader.GetInt32(0);
                    reader.Close();
                }
                using (var command = new NpgsqlCommand($"SELECT * FROM procent_na_prodazba_po_tv() LIMIT {pageSize} OFFSET {(page - 1) * pageSize}", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<ProcentNaProdazbaPoTVDbo> percents = ReflectionHelper.MapDataToBusinessEntityCollection<ProcentNaProdazbaPoTVDbo>(reader);
                    TvListingModel model = new TvListingModel
                    {
                        Page = page,
                        Size = pageSize,
                        Percents = percents,
                        Count = count
                    };
                    return View(model);
                }
            }
        }

        public ActionResult FrequencyTable()
        {
            return View();
        }

        [HttpPost]
        public ActionResult FrequencyTable(int cssn)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand($"SELECT * FROM get_freq_table({cssn})", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<FrequencyTableDbo> table = ReflectionHelper.MapDataToBusinessEntityCollection<FrequencyTableDbo>(reader);
                    return View(table);
                }
            }
        }
        
    }
}