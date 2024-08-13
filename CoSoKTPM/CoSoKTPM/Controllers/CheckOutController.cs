using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Data.Entity;
using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class CheckOutController : Controller
    {
        // GET: CheckOut
        [HttpGet]
        public ActionResult Index()
        {
            //--- Tạo 1 đối tượng khách hàng với thông tin mới truyền ra View
            KhachHang x = new KhachHang();
            //--- Lấy thông tin đã mua hàng từ Session và truyền cho View thông qua ViewData
            CartShop gh = Session["GioHang"] as CartShop;
            //--- Truyền ra ngoài View
            ViewData["Cart"] = gh;
            return View(x);
        }
        [HttpPost]
        public ActionResult SaveToDataBase(KhachHang x)
        {
            //--- Sử dụng transaction để lưu, đồng thời dữ liệu trên 3 table khác nhau
            using (var context = new CoSoKTPMConnect())
            {
                using(DbContextTransaction tt = context.Database.BeginTransaction())
                {
                    try
                    {
                        //--- 1.1/ Tạo mới đối tượng khách hàng và vào miền KhachHang [bảng KhachHang]
                        //--- 1.2/ Cập nhật thông tin khách hàng vào đối tượng KhachHang bạn vừa tạo trước đó
                        x.MaKH = x.SDT;
                        //--- 1.3/ Thêm thông tin khách hàng vào Data model
                        context.KhachHangs.Add(x);
                        //--- 1.4/ Lưu vào database -- [bảng KhachHang]
                        context.SaveChanges();
                        //--- 2.1/ Tạo mới đối tượng đơn hàng và thêm vào miền DonHang -- [bảng DonHang]
                        DonHang d = new DonHang();
                        //--- 2.2/ Cập nhật thông tin đơn hàng vào đối tượng DonHang bạn vừa tạo trước đó
                        d.SoDH = string.Format("{0:yyMMddhhmm}",  DateTime.Now);
                        d.MaKH = x.MaKH;
                        d.NgayDat = DateTime.Now;
                        d.NgayGH = DateTime.Now.AddDays(2);
                        d.TaiKhoan = "hoang";
                        d.DiaChiGH = x.DiaChi;
                        //--- 2.3/ Thêm thông tin đơn hàng vào Data model
                        context.DonHangs.Add(d);
                        //--- 2.4/ Lưu vào database -- [bảng DonHang]
                        context.SaveChanges();
                        //--- 3.1/ Nhận danh sách các mặt hàng từ giỏ hàng -- [bảng CTDonHang]
                        CartShop gh = Session["GioHang"] as CartShop;
                        //--- 3.2/ Cập nhật thông tin chi tiết đơn hàng vào đối tượng CTDonHang bạn vừa tạo trước đó
                        foreach (CtDonHang i in gh.SanPhamDC.Values)
                        {
                            i.SoDH = d.SoDH;
                            context.CtDonHangs.Add(i);
                        }
                        //--- 3.4/ Lưu vào database -- [bảng CTDonHang]
                        context.SaveChanges();
                        //--- 4/ Kết thúc và cam kết tất cả các hành động trên
                        tt.Commit();
                        //--- Chuyển đến trang thông báo đã đặthangf thành công [Chuyển về trang home là chữa cháy]
                        return RedirectToAction("Index", "CheckOutSuccess");
                    }
                    catch(Exception e)
                    {
                        tt.Rollback();
                        string s = e.Message;
                    }
                }
            }
            //--- Nếu bị lỗi sẽ chuyển về trở về CheckOut
            return RedirectToAction("Index", "CheckOut");
        }
    }
}