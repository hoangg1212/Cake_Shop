using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class ProductsDetailController : Controller
    {
        // GET: ProductsDetail
        public ActionResult Index(string MaSP)
        {
            //--- Tạo database context
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            SanPham x = db.SanPhams.Where(z => z.MaSP == MaSP).First<SanPham>();
            //--- Truyền sản phẩm cần xem ra cho View dựa trên ViewData        
            ViewData["SPCanXem"] = x;
            return View();
        }
    }
}