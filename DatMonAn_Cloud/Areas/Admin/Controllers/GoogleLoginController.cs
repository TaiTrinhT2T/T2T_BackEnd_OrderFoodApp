using DatMonAn_Cloud.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatMonAn_Cloud.Areas.Admin.Controllers
{
    public class GoogleLoginController : Controller
    {
        // GET: Admin/GoogleLogin
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public JsonResult ReturnURL(string Email, string Name, string FirstName, string Picture, string GoogleID, string ProfileURL)
        {
            TaiKhoan user = new TaiKhoan();
            user.TenTaiKhoan = Email;
            user.TenTaiKhoan = Name;
            Session["UserAvatar"] = Picture;
            Session["Username"] = Email;
            Session["Name"] = Name;
            return Json(true, JsonRequestBehavior.AllowGet);
        }
    }
}