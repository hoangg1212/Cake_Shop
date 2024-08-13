using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using CoSoKTPM.Models;

namespace CoSoKTPM.Areas.PrivatePages.Data
{
    public class ThuongDung
    {
        public static TaiKhoan GetTaiKhoanHH()
        {
            TaiKhoan a = new TaiKhoan();
            a = HttpContext.Current.Session["TtDangNhap"] as TaiKhoan;
            return a;
        }
        /// <summary>
        /// Lấy tên của tài khoản đã đăng nhập trong hệ thống
        /// </summary>
        /// <returns></returns>
        public static string GetTenTaiKhoan()
        {
            return GetTaiKhoanHH().TaiKhoan1;
        }
    }
}