using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

using CoSoKTPM.Models;
using CoSoKTPM.Areas.PrivatePages.Data;

namespace CoSoKTPM.Areas.PrivatePages.Controllers
{
    public class NewArticleController : Controller
    {
        // GET: PrivatePages/NewArticle
        [HttpGet]
        public ActionResult Index()
        {
            BaiViet a = new BaiViet();
            //--- Thiết một số thông tin mặc định cần gán cho đối tượng bài viết [khách quan]
            a.NgayDang = DateTime.Now;
            a.SoLanDoc = 0;
            a.TaiKhoan = ThuongDung.GetTenTaiKhoan();
            ViewBag.HinhDD = "~/Areas/PrivatePages/Content/images/avatar/avt2.jpg";
            return View(a);
        }
        [HttpPost]
        public ActionResult Index(BaiViet a, HttpPostedFileBase exampleInputFile)
        {
            //-- B1: Xử lý thông tin nhận về từ View
            a.MaBV = string.Format("{0:yyMMddhhmm}", DateTime.Now);
            a.DaDuyet = false;
            a.NgayDang = DateTime.Now;
            a.TaiKhoan = ThuongDung.GetTenTaiKhoan();
            a.SoLanDoc = 0;
            a.LoaiTin = "QC";
            //--
            if (exampleInputFile != null)
            {
                string Virpath = "~/Areas/PrivatePages/Content/images/";
                string phypath = Server.MapPath("~/" + Virpath); //-- Xác định vị trí lưu hình sau khi upload
                string ext = Path.GetExtension(exampleInputFile.FileName);
                string TenF = "HDD" + a.MaBV + "," + ext;
                exampleInputFile.SaveAs(phypath + TenF); //-- Lưu thì phải dựa vào đường dẫn vật lý (ổ đĩa)
                //-- Ghi nhận đường dẫn truy cập tới hình đã lưu trữ dựa vào domain
                a.HinhDD = Virpath + TenF; //-- Đường dẫn ảo 
                                           //-- Sẽ cập nhật hình vừa đăng cho giao diện 
                ViewBag.HinhDD = a.HinhDD;
            }
            else
                a.HinhDD = "";
            //-- B2: Cập nhật đối tượng Bài viết vừa đăng vào data model 
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            db.BaiViets.Add(a);
            //-- B3: Lưu thông tin xuống database
            db.SaveChanges();
            return RedirectToAction("Index", "NewArticle", new { IsActive = 0 });
            return View(a);
        }
    }
}