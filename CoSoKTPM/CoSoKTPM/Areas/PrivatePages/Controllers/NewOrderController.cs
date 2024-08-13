using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class NewOrderController : Controller
    {
        private static CoSoKTPMConnect db = new CoSoKTPMConnect();
        private static bool daKH;
        [HttpGet]
        // GET: PrivatePages/Article
        public ActionResult Index(string IsActive)
        {
            daKH = IsActive != null && IsActive.Equals("1");
            CapNhatDuLieuChoGiaoDien();
            return View();
        }
        [HttpPost]
        public ActionResult Delete(string soDH)
        {
            //-- B1: Dùng lệnh để hiển thị đơn hàng chưa được xử lý dựa vào số đơn hàng
            DonHang x = db.DonHangs.Find(soDH);
            db.DonHangs.Remove(x);
            //-- B2: Cập nhật database
            db.SaveChanges();
            //-- B3: Hiển thị lại đơn hàng sau khi chuyển vào danh sách chưa xử lý
            CapNhatDuLieuChoGiaoDien();
            return View("Index");
        }
        [HttpPost]
        public ActionResult Active(string soDH)
        {
            //-- B1: Dùng lệnh để cấm bài viết dựa vào mã bài viết
            DonHang x = db.DonHangs.Find(soDH);
            x.DaKichHoat = !daKH;
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

            List<DonHang> l = db.DonHangs.Where(x => x.DaKichHoat == daKH).ToList<DonHang>();
            ViewData["DanhSachDH"] = l;
            ViewBag.taCuaNut = daKH ? "Chưa xử lý" : "Xóa";
        }
    }
}