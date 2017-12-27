using DatMonAn_Cloud.Entity;
using DatMonAn_Cloud.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;

namespace DatMonAn_Cloud.Controllers
{
    public class DatHangController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();
        [Route("api/DatHang")]
        [HttpGet]
        public IHttpActionResult GetDatHangs(int idStore, int idUser, string address, int tongTien, string jonListProduct)
        {
            // taiKhoan = "admin@gmail.com"
            // pass = "123456789"

            var listProducts = JsonConvert.DeserializeObject<List<ModelProducts>>(jonListProduct);
            int lenListProduct = listProducts.Count();

            var exProc = db.Database.SqlQuery<int>("exec DonHang_Insert @idStore, @idUser, @ThoiGian, @DiaChi, @TongTien",
               new SqlParameter("idStore", idStore),
               new SqlParameter("idUser", idUser),
               new SqlParameter("ThoiGian", DateTime.Now),
               new SqlParameter("DiaChi", address),
               new SqlParameter("TongTien", tongTien)
               )
               .ToArray();
            //IEnumerable<string> result = res;
            int idDonHang = exProc[0];

            
            int i;
            for ( i = 0; i < lenListProduct; i++)
            {
                ModelProducts item = listProducts[i];
                db.Database.ExecuteSqlCommand("exec DatHang_Insert @iddonhang, @idMonAn, @count",
               new SqlParameter("iddonhang", idDonHang),
               new SqlParameter("idMonAn", item.id),
               new SqlParameter("count", item.count));
            }

            string json = "{\"status\": 0}";

            return Ok(json);
        }
    }
}
