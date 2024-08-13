using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace CoSoKTPM.Models
{
    public class Common
    {
        /// <summary>
        /// Hàm lấy danh sách tất cả các sản phẩm thuộc một loại nào đó 
        /// </summary>
        /// <returns></returns>
        public static List<SanPham> getProducts()
        {
            List<SanPham> l = new List<SanPham>();
            //--- Khai báo 1 đối tượng đại diện cho database
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            //--- Lấy dữ liệu
            l = cn.Set<SanPham>().ToList<SanPham>();
            return l;
        }
        public static List<SanPham> getProductsByLoaiSP(int maLoai)
        {
            List<SanPham> l = new List<SanPham>();
            //--- Khai báo 1 đối tượng đại diện cho database
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            //--- Lấy dữ liệu
            l = cn.Set<SanPham>().Where( x => x.MaLoai == maLoai).ToList<SanPham>();
            return l;
        }
        /// <summary>
        /// Hàm cho phép lấy ra danh sách các chủng loại hàng hóa
        /// </summary>
        /// <returns></returns>
        public static List<LoaiSP> getCategories()
        {
            return new DbContext("name=CoSoKTPMConnect").Set<LoaiSP>().ToList<LoaiSP>();
        }
        public static List<BaiViet> getArticles(int n)
        {
            List<BaiViet> l = new List<BaiViet>();
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            l = db.BaiViets.Where(m => m.DaDuyet == true).OrderByDescending(bv => bv.NgayDang).Take(n).ToList<BaiViet>();
            return l;
        }
        public static LoaiSP getLoaiSPById(int maLoai)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<LoaiSP>().Find(maLoai);
        }
        /// <summary>
        ///  Phương thức cho phép lấy thông tin của một sản phẩm dựa vào mã sản phẩm đó
        /// </summary>
        /// <param name="maLoai"> Mã sản phẩm </param>
        /// <returns> Đối tượng sản phẩm láya được từ data model </returns>
        public static SanPham GetProdutsById(string maLoai)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maLoai);
        }
        /// <summary>
        /// Lấy tên của sản phẩm dựa vào mã 
        /// </summary>
        /// <param name="maSP"></param>
        /// <returns></returns>
        public static string getNameOfProductByID(string maSP)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maSP).TenSP;
        }
        /// <summary>
        /// Lấy đường dẫn hình đại diện dựa vào mã sản phẩm
        /// </summary>
        /// <param name="maSP"></param>
        /// <returns></returns>
        public static string getImageOfProductByID(string maSP)
        {
            DbContext cn = new DbContext("name=CoSoKTPMConnect");
            return cn.Set<SanPham>().Find(maSP).HinhDD;
        }
    }
}
   