using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class GalleryController : Controller
    {
        // GET: Gallery
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        public ActionResult Index()
        {
            List<SanPham> l = new CoSoKTPMConnect().SanPhams.OrderBy(x => x.HinhDD).ToList<SanPham>();
            ViewData["DanhSachHinh"] = l;
            return View();
        }
    }
}