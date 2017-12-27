using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatMonAn_Cloud.Areas.Admin.Controllers
{
    public class NhaHangController : Controller
    {
        // GET: Admin/NhaHang
        public ActionResult Index()
        {
            return View("Index");
        }
    }
}