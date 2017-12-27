using DatMonAn_Cloud.Entity;
using DatMonAn_Cloud.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DatMonAn_Cloud.Controllers
{
    public class HistoriesController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET api/Histories
        public List<History> GetTaiKhoans(int idAccount)
        {
            var exProc = db.Database.SqlQuery<History>("exec SelectHistoryById @id",
               new SqlParameter("id", idAccount)).ToList();
           
            return exProc;
        }

        // GET api/AccountInsert
        [Route("api/DetailHistory")]
        [HttpGet]
        public IHttpActionResult GetDetailHistory(int idDonHang)
        {
            var exProc = db.Database.SqlQuery<ModelChiTietDonHang>("exec ChiTietHoaDon @idDonHang",
               new SqlParameter("idDonHang", idDonHang)
               ).ToList();
            return Ok(exProc);
        }
    }
}
