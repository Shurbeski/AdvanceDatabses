using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NapredniBazi.Models
{
    public class OrderFromWareHouseModel
    {
        public int Code { get; set; }
        public List<StoreStockDbo> Stores { get; set; }
        public int StoreId { get; set; }
        public int Quantity { get; set; }
    }
}