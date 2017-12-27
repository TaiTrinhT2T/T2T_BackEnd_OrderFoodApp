using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DatMonAn_Cloud.Models
{
    public class ModelOrder
    {
        public int idStore { get; set; }
        public int idUser { get; set; }
        public string address { get; set; }
        public int total { get; set; }
        public List<InforOrder> products { get; set; }
    }
}