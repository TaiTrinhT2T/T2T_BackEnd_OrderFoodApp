using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DatMonAn_Cloud.Models
{
    public class ModelDatHang
    {
        public string TenTaiKhoan { get; set; }
        public string TenNhaHang { get; set; }
        public int TrangThai { get; set; }
        public DateTime ThoiGian { get; set; }
        public string TenMonAn { get; set; }
        public int SoLuong { get; set; }
    }
}