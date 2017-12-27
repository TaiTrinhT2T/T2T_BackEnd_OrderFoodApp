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
using System.Web.Http.Cors;
using System.Data.SqlClient;
using DatMonAn_Cloud.Models;

namespace DatMonAn_Cloud.Controllers
{
    [EnableCors(origins: "http://datmonancloud.azurewebsites.net", headers: "*", methods: "*")]
    public class MonAnsController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET: api/MonAns
        public IQueryable<MonAn> GetMonAns()
        {
            return db.MonAns;
        }

        [Route("api/getAllMonAn")]
        [HttpGet]
        public List<Dish> GetAllMonAn(int numberPage)
        {
            var res = db.Database.SqlQuery<Dish>("exec SelectAll_MonAn @TS, @BG",
                new SqlParameter("TS", numberPage),
                new SqlParameter("BG", 10)).ToList();
            return res;
        }

        // GET: api/MonAns/5
        [ResponseType(typeof(MonAn))]
        public IHttpActionResult GetMonAn(int id)
        {
            MonAn monAn = db.MonAns.Find(id);
            if (monAn == null)
            {
                return NotFound();
            }

            return Ok(monAn);
        }

        // GET: api/MonAns/
        [ResponseType(typeof(MonAn))]
        public List<MonAn> GetTimKiemMonAn(string key)
        {
            if(key == null)
            {
                key = "";
            }
            var exProc = db.Database.SqlQuery<MonAn>("exec TimKiem_MonAns @search",
               new SqlParameter("search", key)).ToList();
            return exProc;
        }

        // PUT: api/MonAns/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutMonAn(MonAn monAn)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Entry(monAn).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MonAnExists(monAn.ID_MonAn))
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

        // POST: api/MonAns
        [ResponseType(typeof(MonAn))]
        public IHttpActionResult PostMonAn(MonAn monAn)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.MonAns.Add(monAn);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = monAn.ID_MonAn }, monAn);
        }

        // DELETE: api/MonAns/5
        [ResponseType(typeof(MonAn))]
        public IHttpActionResult DeleteMonAn(MonAn monan)
        {
            MonAn monAn = db.MonAns.Find(monan.ID_MonAn);
            if (monAn == null)
            {
                return NotFound();
            }

            db.MonAns.Remove(monAn);
            db.SaveChanges();

            return Ok(monAn);
        }

        [ResponseType(typeof(MonAn))]
        public List<MonAn> TimKiemMonAn(string search)
        {
            var exProc = db.Database.SqlQuery<MonAn>("exec Searchss_MonAnss @search",
               new SqlParameter("search", search)).ToList();
            return exProc;
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool MonAnExists(int id)
        {
            return db.MonAns.Count(e => e.ID_MonAn == id) > 0;
        }
    }
}