using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        [HttpGet]
        public ActionResult Index()
        {
            //--- Lấy giỏ hàng từ Session
            CartShop gh = Session["GioHang"] as CartShop;
            //--- Truyền ra ngoài View
            ViewData["Cart"] = gh;
            return View();
        }
        public ActionResult Increase(string MaSP)
        {
            //--- Lấy giỏ hàng từ Session
            CartShop gh = Session["GioHang"] as CartShop;
            gh.addItem(MaSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
        public ActionResult Decrease(string MaSP)
        {
            //--- Lấy giỏ hàng từ Session
            CartShop gh = Session["GioHang"] as CartShop;
            gh.decrease(MaSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
        public ActionResult RemoveItem(string MaSP)
        {
            //--- Lấy giỏ hàng từ Session
            CartShop gh = Session["GioHang"] as CartShop;
            gh.deleteItem(MaSP);
            Session["GioHang"] = gh;
            return RedirectToAction("Index");
        }
    }
}