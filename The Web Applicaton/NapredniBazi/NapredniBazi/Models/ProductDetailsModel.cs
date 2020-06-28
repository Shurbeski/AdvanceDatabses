using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NapredniBazi.Models
{
    public class ProductDetailsModel : PaginationModel
    {
        public IEnumerable<StockDbo> Stocks { get; set; }
        public int Code { get; internal set; }
    }
}