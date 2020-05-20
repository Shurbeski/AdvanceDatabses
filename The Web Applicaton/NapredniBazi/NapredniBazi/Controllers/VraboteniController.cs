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
    public class VraboteniController : Controller
    {
        // GET: Vraboteni
        public ActionResult Index(int page = 1, int pageSize = 20)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                int count;
                using (var command = new NpgsqlCommand($"SELECT COUNT(product.code) FROM product", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    count = reader.GetInt32(0);
                    reader.Close();
                }
                using (var command = new NpgsqlCommand($"SELECT * FROM product LIMIT {pageSize} OFFSET {(page - 1) * pageSize}", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<ProductDbo> products = ReflectionHelper.MapDataToBusinessEntityCollection<ProductDbo>(reader);
                    ProductListingModel model = new ProductListingModel
                    {
                        Page = page,
                        Size = pageSize,
                        Products = products,
                        Count = count
                    };
                    return View(model);
                }
            }
        }

        public ActionResult Order(int code)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand($@"SELECT store.*, stock.cnt as stock FROM store, stock 
                                                        WHERE store.id = stock.store_id 
                                                            AND stock.product_code = {code}
                                                        ORDER BY store.name ASC", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<StoreStockDbo> stores = ReflectionHelper.MapDataToBusinessEntityCollection<StoreStockDbo>(reader);
                    OrderFromWareHouseModel model = new OrderFromWareHouseModel
                    {
                        Code = code,
                        Stores = stores,
                        Quantity = 1
                    };
                    return View(model);
                }
            }

        }

        [HttpPost]
        public ActionResult Order(int code, OrderFromWareHouseModel model)
        {
            model.StoreId = int.Parse(Request.Params["store-id"]);
            if (!ModelState.IsValid)
                return View("Order", model);
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand($"SELECT narachka({model.StoreId}, {model.Code}, {model.Quantity})", connection))
                {
                    try
                    {
                        NpgsqlDataReader reader = command.ExecuteReader();
                    }
                    catch (Exception)
                    {
                        ModelState.AddModelError(String.Empty, $"Unexpected error has occured");
                        return View("Order", model);
                    }

                }
                return View("OrderPlaced");

            }
        }
    }
}