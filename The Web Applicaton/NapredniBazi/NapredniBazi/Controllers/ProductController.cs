using NapredniBazi.Models;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NapredniBazi.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
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
                using (var command = new NpgsqlCommand($"SELECT * FROM product LIMIT {pageSize} OFFSET {(page-1) * pageSize}", connection))
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

        public ActionResult PlaceOrder(int code)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand($@"SELECT store.* FROM store, stock 
                                                        WHERE store.id = stock.store_id 
                                                            AND stock.product_code = {code}
                                                            AND count > 0
                                                        ORDER BY store.name ASC", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<StoreDbo> stores = ReflectionHelper.MapDataToBusinessEntityCollection<StoreDbo>(reader);
                    PlaceOrderModel model = new PlaceOrderModel
                    {
                        Code = code,
                        Stores = stores,
                        Quantity = 1
                    };
                    return View(model);
                }
            }

        }

        public ActionResult Details(int code, int page = 1, int pageSize = 20)
        {
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                int count;
                using (var command = new NpgsqlCommand($@"SELECT COUNT(product.*) FROM product 
                                                        WHERE product.code = { code }", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    if (reader.GetInt32(0) == 0)
                        return HttpNotFound();
                    reader.Close();
                }
                using (var command = new NpgsqlCommand($@"SELECT COUNT(stock.*) FROM stock 
                                                        WHERE stock.product_code = { code }
                                                        AND stock.count > 0", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    count = reader.GetInt32(0);
                    reader.Close();
                }
                using (var command = new NpgsqlCommand($@"SELECT stock.* FROM stock 
                                                        WHERE stock.product_code = {code}
                                                        AND stock.count > 0
                                                        LIMIT {pageSize} OFFSET {(page - 1) * pageSize}", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    List<StockDbo> stocks = ReflectionHelper.MapDataToBusinessEntityCollection<StockDbo>(reader);
                    ProductDetailsModel model = new ProductDetailsModel
                    {
                        Count = count,
                        Page = page,
                        Size = pageSize,
                        Stocks = stocks,
                        Code = code
                    };
                    return View(model);
                }
            }
        }

        [HttpPost]
        public ActionResult PlaceOrder(int code, PlaceOrderModel model)
        {
            model.StoreId = int.Parse(Request.Params["store-id"]);
            if (!ModelState.IsValid)
                return View("PlaceOrder", model);
            using (var connection = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["postgres"].ConnectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand($@"SELECT stock.count FROM store, stock 
                                                        WHERE store.id = {model.StoreId}
                                                            AND stock.product_code = {model.Code}", connection))
                {
                    NpgsqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    int stock = reader.GetInt32(0);
                    if(stock < model.Quantity)
                    {
                        ModelState.AddModelError("Quantity", $"Stock in store({stock}) is less than entered quantity");
                        return View("PlaceOrder", model);
                    }
                    reader.Close();
                }
                using (var command = new NpgsqlCommand($"SELECT kupuvanje_proizvodi({model.StoreId}, {model.Code}, {model.Quantity})", connection))
                {
                    try
                    {
                        NpgsqlDataReader reader = command.ExecuteReader();
                    }
                    catch (Exception)
                    {
                        //otkako vnesiv place order, trebase da zgolemi +50 ovaj exception go frli
                        ModelState.AddModelError(string.Empty, $"Unexpected error has occured");
                        return View("PlaceOrder", model);
                    }

                }
                return View("OrderPlaced");

            }
        }
    }
}
