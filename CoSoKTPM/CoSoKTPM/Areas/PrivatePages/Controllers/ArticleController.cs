using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class ArticleController : Controller
    {
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool daDuyet;
        [HttpGet]
        // GET: PrivatePages/Article
        public ActionResult Index(string IsActive)
        {
            daDuyet = IsActive != null && IsActive.Equals("1");
            CapNhatDuLieuChoGiaoDien();
            return View();
        }
        [HttpPost]
        public ActionResult Delete(string maBaiViet)
        {
            //-- B1: Dùng lệnh để xóa bài viết dựa vào mã bài viết
            BaiViet x = db.BaiViets.Find(maBaiViet);
            db.BaiViets.Remove(x);
            //-- B2: Cập nhật database
            db.SaveChanges();
            //-- B3: Hiển thị lại danh sách sau khi xóa
            CapNhatDuLieuChoGiaoDien();
            return View("Index");
        }
        [HttpPost]
        public ActionResult Active(string maBaiViet)
        {
            //-- B1: Dùng lệnh để cấm bài viết dựa vào mã bài viết
            BaiViet x = db.BaiViets.Find(maBaiViet);
            x.DaDuyet = !daDuyet;
            //-- B2: Cập nhật database
            db.SaveChanges();
            //-- B3: Hiển thị lại danh sách sau khi xóa
            CapNhatDuLieuChoGiaoDien();
            return View("Index");
        }
        /// <summary>
        /// Hàm phục vụ cho mục tiêu cập nhật dữ liệu cho View của controller này thông uqa ViewData object
        /// </summary>
        private void CapNhatDuLieuChoGiaoDien()
        {

            List<BaiViet> l = db.BaiViets.Where(x => x.DaDuyet == daDuyet).ToList<BaiViet>();
            ViewData["DanhSachBV"] = l;
            ViewBag.taCuaNut = daDuyet ? "Cấm hiển thị" : "Kiểm duyệt bài";

        }
    }
}