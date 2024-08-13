using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class SPDKDController : Controller
    {
        // GET: PrivatePages/Customer
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool DaDuyet;
        [HttpGet]
        // GET: PrivatePages/Customers
        public ActionResult Index()
        {
            List<SanPham> l = new CoSoKTPMConnect().SanPhams.OrderBy(x => x.MaSP).ToList<SanPham>();
            ViewData["DanhSachSP"] = l;
            return View();
        }
    }
}