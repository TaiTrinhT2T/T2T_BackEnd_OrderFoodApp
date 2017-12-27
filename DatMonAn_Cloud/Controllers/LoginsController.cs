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
    public class LoginsController : ApiController
    {
        private DatmonanEntities db = new DatmonanEntities();

        // GET api/Login
        public bool GetTaiKhoans(string taiKhoan, string pass)
        {
            // taiKhoan = "admin@gmail.com"
            // pass = "123456789"
            var exProc = db.Database.SqlQuery<int>("exec Login_CheckAccount @NameOrEmail, @Password",
               new SqlParameter("NameOrEmail", taiKhoan),
               new SqlParameter("Password", pass)).ToArray();
            //IEnumerable<string> result = res;
            int kq = exProc[0];
            bool res;
            if (kq == 0)
            {
                // kq == 0 hay false : Nghia la tai khoan, mat khau sai
                // Dang nhap Failed
                res = false;
            }
            else
            {
                // kq == 1 hay true : Nghia la tai khoan, mat khau dung
                // Dang nhap Success
                res = true;
            }
            return res;
        }

        // POST api/TestPost    
        [Route("api/TestPost")]
        [HttpPost]
        public IHttpActionResult PostTest([FromBody]TaiKhoan a)
        {
            return Ok(a);
        }

        // POST api/LoginPost
        [Route("api/LoginPost")]
        [HttpPost]
        public IHttpActionResult PostTaiKhoans([FromBody] AccountLogin u)
        {
            // taiKhoan = "admin@gmail.com"
            // pass = "123456789"
            var exProc = db.Database.SqlQuery<int>("exec Login_CheckAccount @NameOrEmail, @Password",
               new SqlParameter("NameOrEmail", u.email),
               new SqlParameter("Password", u.matKhau)).ToArray();
            //IEnumerable<string> result = res;
            int kq = exProc[0];
            if (kq == 0)
            {
                TaiKhoan a = new TaiKhoan();
                // kq == 0 hay false : Nghia la tai khoan, mat khau sai
                // Dang nhap Failed
                return Ok(a);
            }
            else
            {
                // kq == 1 hay true : Nghia la tai khoan, mat khau dung
                // Dang nhap Success
                var exProcSelectAccount = db.Database.SqlQuery<TaiKhoan>("exec Login_SelectAccount @NameOrEmail, @Password",
               new SqlParameter("NameOrEmail", u.email),
               new SqlParameter("Password", u.matKhau)).ToList();
                //IEnumerable<string> result = res;
                var accoutn = exProcSelectAccount[0];
                return Ok(accoutn);
            }
        }

        // GET api/AccountInsert
        [Route("api/AccountInsert")]
        [HttpGet]
        public IHttpActionResult GetAccountInserts(string tenTaiKhoan, string email, string soDienThoai, string matKhau)
        {
            var exProc = db.Database.SqlQuery<int>("exec TaiKhoan_Insert @TenTaiKhoan, @Email, @SoDienThoai, @MatKhau",
               new SqlParameter("TenTaiKhoan", tenTaiKhoan),
               new SqlParameter("Email", email),
               new SqlParameter("SoDienThoai", soDienThoai),
               new SqlParameter("MatKhau", matKhau)
               ).ToArray();
            //IEnumerable<string> result = res;
            int kq = exProc[0];
            if (kq == 0)
            {
                TaiKhoan a = new TaiKhoan();
                // kq == 0 hay false : Nghia la tai khoan, mat khau sai
                // Dang nhap Failed
                return Ok(a);
            }
            else
            {
                // kq == 1 hay true : Nghia la tai khoan, mat khau dung
                // Dang nhap Success
                var exProcSelectAccount = db.Database.SqlQuery<TaiKhoan>("exec Login_SelectAccount @NameOrEmail, @Password",
               new SqlParameter("NameOrEmail", email),
               new SqlParameter("Password", matKhau)).ToList();
                //IEnumerable<string> result = res;
                var accoutn = exProcSelectAccount[0];
                return Ok(accoutn);
            }
        }

        // GET api/AccountInsert
        [Route("api/AccountUpdate")]
        [HttpGet]
        public IHttpActionResult GetAccountUpdates(int idTaiKhoan,string tenTaiKhoan, string soDienThoai)
        {
            var exProc = db.Database.SqlQuery<int>("exec UpdateUser @HoTen , @SDT , @ID_user",
               new SqlParameter("HoTen", tenTaiKhoan),
               new SqlParameter("SDT", soDienThoai),
               new SqlParameter("ID_user", idTaiKhoan)
               ).ToArray();
            //IEnumerable<string> result = res;
            int kq = exProc[0];
            if (kq == 0)
            {
                TaiKhoan a = new TaiKhoan();
                // kq == 0 hay false : Nghia la tai khoan, mat khau sai
                // Dang nhap Failed
                return Ok(a);
            }
            else
            {
                // kq == 1 hay true : Nghia la tai khoan, mat khau dung
                // Dang nhap Success
                var exProcSelectAccount = db.Database.SqlQuery<TaiKhoan>("exec TaiKhoan_SelectById @id",
               new SqlParameter("id", idTaiKhoan)).ToList();
                //IEnumerable<string> result = res;
                var accoutn = exProcSelectAccount[0];
                return Ok(accoutn);
            }
        }
    }
}
