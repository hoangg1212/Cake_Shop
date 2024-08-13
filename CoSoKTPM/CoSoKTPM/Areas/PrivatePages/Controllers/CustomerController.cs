using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class CustomerController : Controller
    {
        // GET: PrivatePages/Customer
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool gioiTinh;
        [HttpGet]
        // GET: PrivatePages/Customers
        public ActionResult Index()
        {
            List<KhachHang> l = new CoSoKTPMConnect().KhachHangs.OrderBy(x => x.MaKH).ToList<KhachHang>();
            ViewData["DanhSachKH"] = l;
            return View(); 
        }
    }
}