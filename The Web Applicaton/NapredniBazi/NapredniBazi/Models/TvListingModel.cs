using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NapredniBazi.Models
{
    public class TvListingModel: PaginationModel
    {
        public IEnumerable<ProcentNaProdazbaPoTVDbo> Percents { get; set;}
    }
}