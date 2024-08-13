using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        [HttpGet]
        public ActionResult Index()
        {
            List<SanPham> l = Common.getProductsByLoaiSP(1);
            return View();
        }
        public ActionResult AddToCart(string MaSP)
        {
            CartShop gh = Session["GioHang"] as CartShop;
            gh.addItem(MaSP);
            Session["GioHang"] = gh;
            return View("Index");
        }
    }
}