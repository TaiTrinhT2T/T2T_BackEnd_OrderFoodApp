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
    public class NhaHangsController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET: api/NhaHangs
        public IQueryable<NhaHang> GetNhaHangs()
        {
            return db.NhaHangs;
        }

        // GET: api/NhaHangs/5
        [ResponseType(typeof(NhaHang))]
        public IHttpActionResult GetNhaHang(int id)
        {
            NhaHang nhaHang = db.NhaHangs.Find(id);
            if (nhaHang == null)
            {
                return NotFound();
            }

            return Ok(nhaHang);
        }

        // GET: api/MonAns/
        [ResponseType(typeof(NhaHang))]
        public List<NhaHang> GetTimKiemNhaHang(string key)
        {
            if (key == null)
            {
                key = "";
            }
            var exProc = db.Database.SqlQuery<NhaHang>("exec TimKiem_NhaHangs @search",
               new SqlParameter("search", key)).ToList();
            return exProc;
        }

        // PUT: api/NhaHangs/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutNhaHang(NhaHang nhaHang)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Entry(nhaHang).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NhaHangExists(nhaHang.ID_NhaHang))
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

        // POST: api/NhaHangs
        [ResponseType(typeof(NhaHang))]
        public IHttpActionResult PostNhaHang(NhaHang nhaHang)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.NhaHangs.Add(nhaHang);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = nhaHang.ID_NhaHang }, nhaHang);
        }

        // DELETE: api/NhaHangs/5
        [ResponseType(typeof(NhaHang))]
        public IHttpActionResult DeleteNhaHang(NhaHang nh)
        {
            NhaHang nhaHang = db.NhaHangs.Find(nh.ID_NhaHang);
            if (nhaHang == null)
            {
                return NotFound();
            }

            db.NhaHangs.Remove(nhaHang);
            db.SaveChanges();

            return Ok(nhaHang);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool NhaHangExists(int id)
        {
            return db.NhaHangs.Count(e => e.ID_NhaHang == id) > 0;
        }
    }
}