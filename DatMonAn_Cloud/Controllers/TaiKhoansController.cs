using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using DatMonAn_Cloud.Entity;
using System.Data.SqlClient;

namespace DatMonAn_Cloud.Controllers
{
    public class TaiKhoansController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET: api/TaiKhoans
        public IQueryable<TaiKhoan> GetTaiKhoans()
        {
            return db.TaiKhoans;
        }

        // GET: api/TaiKhoans/5
        [ResponseType(typeof(TaiKhoan))]
        public IHttpActionResult GetTaiKhoan(int id)
        {
            TaiKhoan taiKhoan = db.TaiKhoans.Find(id);
            if (taiKhoan == null)
            {
                return NotFound();
            }

            return Ok(taiKhoan);
        }

        // GET: api/MonAns/
        [ResponseType(typeof(TaiKhoan))]
        public List<TaiKhoan> GetTimKiemNhaHang(string key)
        {
            if (key == null)
            {
                key = "";
            }
            var exProc = db.Database.SqlQuery<TaiKhoan>("exec TimKiem_TaiKhoans @search",
               new SqlParameter("search", key)).ToList();
            return exProc;
        }

        // PUT: api/TaiKhoans/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutTaiKhoan(TaiKhoan taiKhoan)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
           

            db.Entry(taiKhoan).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TaiKhoanExists(taiKhoan.ID_TaiKhoan))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/TaiKhoans
        [ResponseType(typeof(TaiKhoan))]
        public IHttpActionResult PostTaiKhoan(TaiKhoan taiKhoan)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.TaiKhoans.Add(taiKhoan);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = taiKhoan.ID_TaiKhoan }, taiKhoan);
        }

        // DELETE: api/TaiKhoans/5
        [ResponseType(typeof(TaiKhoan))]
        public IHttpActionResult DeleteTaiKhoan(TaiKhoan tk)
        {
            TaiKhoan taiKhoan = db.TaiKhoans.Find(tk.ID_TaiKhoan);
            if (taiKhoan == null)
            {
                return NotFound();
            }

            db.TaiKhoans.Remove(taiKhoan);
            db.SaveChanges();

            return Ok(taiKhoan);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TaiKhoanExists(int id)
        {
            return db.TaiKhoans.Count(e => e.ID_TaiKhoan == id) > 0;
        }
    }
}