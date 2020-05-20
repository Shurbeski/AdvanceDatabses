using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NapredniBazi.Models
{
    public class ProductDbo
    {
        public int Code { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public string C_of_production { get; set; }
        public int Category_id { get; set; }
    }
}