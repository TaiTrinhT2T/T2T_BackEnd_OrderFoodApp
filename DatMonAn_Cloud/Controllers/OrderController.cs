using DatMonAn_Cloud.Entity;
using DatMonAn_Cloud.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DatMonAn_Cloud.Controllers
{
    public class OrderController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();
        [Route("api/Order")]
        [HttpPost]
        public IHttpActionResult GetDatHangs([FromBody]ModelOrder order)
        {
            // taiKhoan = "admin@gmail.com"
            // pass = "123456789"

            ////JObject json = JObject.Parse(order.products);
            //JArray ps = (JArray)json.GetValue("products");
            //int total = (int)json.GetValue("total");]

            List<InforOrder> listOrder = order.products;
            int tong = order.total;

            var exProc = db.Database.SqlQuery<int>("exec DonHang_Insert @idStore, @idUser, @ThoiGian, @DiaChi, @TongTien",
               new SqlParameter("idStore", order.idStore),
               new SqlParameter("idUser", order.idUser),
               new SqlParameter("ThoiGian", DateTime.Now),
               new SqlParameter("DiaChi", order.address),
               new SqlParameter("TongTien", tong)
               )
               .ToArray();
            //IEnumerable<string> result = res;
            int idDonHang = exProc[0];

            
            foreach (InforOrder item in listOrder)
            {
                ModelProducts model = new ModelProducts();
                model.id = item.id;
                model.count = item.count;
                db.Database.ExecuteSqlCommand("exec DatHang_Insert @iddonhang, @idMonAn, @count",
               new SqlParameter("iddonhang", idDonHang),
               new SqlParameter("idMonAn", model.id),
               new SqlParameter("count", model.count));
            }
            JObject res = new JObject();
            res["status"] = 0;

            return Ok(res.ToString());
        }
    }
}
