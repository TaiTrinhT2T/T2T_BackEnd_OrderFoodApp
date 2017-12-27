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

namespace DatMonAn_Cloud.Controllers
{
    public class DonHangsController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET: api/DonHangs
        public IQueryable<DonHang> GetDonHangs()
        {
            return db.DonHangs;
        }

        // GET: api/DonHangs/5
        [ResponseType(typeof(DonHang))]
        public IHttpActionResult GetDonHang(int id)
        {
            DonHang donHang = db.DonHangs.Find(id);
            if (donHang == null)
            {
                return NotFound();
            }

            return Ok(donHang);
        }

        // PUT: api/DonHangs/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutDonHang(int id, DonHang donHang)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != donHang.ID_DonHang)
            {
                return BadRequest();
            }

            db.Entry(donHang).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DonHangExists(id))
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

        // POST: api/DonHangs
        [ResponseType(typeof(DonHang))]
        public IHttpActionResult PostDonHang(DonHang donHang)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.DonHangs.Add(donHang);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = donHang.ID_DonHang }, donHang);
        }

        // DELETE: api/DonHangs/5
        [ResponseType(typeof(DonHang))]
        public IHttpActionResult DeleteDonHang(int id)
        {
            DonHang donHang = db.DonHangs.Find(id);
            if (donHang == null)
            {
                return NotFound();
            }

            db.DonHangs.Remove(donHang);
            db.SaveChanges();

            return Ok(donHang);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool DonHangExists(int id)
        {
            return db.DonHangs.Count(e => e.ID_DonHang == id) > 0;
        }
    }
}