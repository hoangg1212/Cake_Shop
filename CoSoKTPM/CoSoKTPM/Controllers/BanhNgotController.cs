using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class BanhNgotController : Controller
    {
        // GET: BanhNgot
        public ActionResult Index()
        {
            List<SanPham> l = Common.getProductsByLoaiSP(1);
            return View();
        }
    }
}