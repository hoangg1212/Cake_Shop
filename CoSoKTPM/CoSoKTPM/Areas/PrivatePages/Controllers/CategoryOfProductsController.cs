using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class CategoryOfProductsController : Controller
    {
        // GET: PrivatePages/CategoryOfProducts
        private static bool isUpdate = false;
        // GET: PrivatePages/CategoryOfProducts
        [HttpGet]
        public ActionResult Index()
        {
            List<LoaiSP> l = new CoSoKTPMConnect().LoaiSPs.OrderBy(x => x.TenLoai).ToList<LoaiSP>();
            ViewData["DsLoai"] = l;
            return View();
        }
        [HttpPost]
        public ActionResult Index(LoaiSP x)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            //--- Bước 1: Add LoaiSP object to data model
            if (!isUpdate)
                db.LoaiSPs.Add(x);
            else
            {
                LoaiSP y = db.LoaiSPs.Find(x.MaLoai);
                y.TenLoai = x.TenLoai;
                y.GhiChu = x.GhiChu;
                isUpdate = false;
            }
            db.SaveChanges(); //-- Save data to database
            //--- Update list to view
            if (ModelState.IsValid)
                ModelState.Clear();
            List<LoaiSP> l = db.LoaiSPs.OrderBy(z => z.TenLoai).ToList<LoaiSP>();
            ViewData["DsLoai"] = l;
            return View();
        }
        [HttpPost]
        public ActionResult Delete(string maLoai)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            int ma = int.Parse(maLoai);
            //-- B1: Find LoaiSP object in data model by maLoai
            LoaiSP x = db.LoaiSPs.Find(ma);
            //-- B2: Remove LoaiSp object from data modle
            db.LoaiSPs.Remove(x);
            //-- B3: Update to database
            db.SaveChanges();
            //-- B4: Update data on View
            List<LoaiSP> l = db.LoaiSPs.OrderBy(z => z.TenLoai).ToList<LoaiSP>();
            ViewData["DsLoai"] = l;
            return View("Index");
        }
        public ActionResult Update(string maLoaiCS)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            int ma = int.Parse(maLoaiCS);
            //-- B1: Find LoaiSP object in data model by maLoai
            LoaiSP x = db.LoaiSPs.Find(ma);
            isUpdate = true;
            //-- ???
            List<LoaiSP> l = db.LoaiSPs.OrderBy(z => z.TenLoai).ToList<LoaiSP>();
            ViewData["DsLoai"] = l;
            return View("Index", x);
        }
    }
}