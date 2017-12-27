using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DatMonAn_Cloud.Models
{
    public class Dish
    {
        public int ID_MonAn { get; set; }
        public String TenMonAn { get; set; }
        public String MoTa { get; set; }
        public String GiaBan { get; set; }
        public String GiaKhuyenMai { get; set; }
        public String SrcImg { get; set; }
    }
}