using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(string Acc, string Pass)
        {
            string mk = MaHoa.encrytSHA256(Pass);
            //-- đọc thông tin tài khoản từ database thông qua dât model để xét có đúng tài khoản và mật khẩu không
            TaiKhoan ttdn = new CoSoKTPMConnect().TaiKhoans.Where(x => x.TaiKhoan1.Equals(Acc.ToLower().Trim()) && x.MatKhau.Equals(mk)).First<TaiKhoan>();
            //-- Lấy được thông tin database và đúng .... thi cho phép vào Private pages
            bool isAuthentic = ttdn != null && ttdn.TaiKhoan1.Equals(Acc.ToLower().Trim()) && ttdn.MatKhau.Equals(mk);
            if (isAuthentic)
            {
                Session["TtDangNhap"] = ttdn;
                return RedirectToAction("Index", "Dashboard", new { Area = "PrivatePages" });
            }
            // không thành công thì vẫn nhập lại được bth....
            return View();
        }
    }
}