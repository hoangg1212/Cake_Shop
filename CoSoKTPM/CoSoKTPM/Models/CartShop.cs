using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CoSoKTPM.Models
{
    public class CartShop
    {
        public string TenKH { get; set; }
        public string MaKH { get; set; }
        public string TaiKhoan { get; set; }
        public DateTime NgayDat { get; set; }
        public DateTime NgayGH { get; set; }
        public string DiaChiGH { get; set; }
        /// <summary>
        /// Defau constructor
        /// </summary>
        public CartShop()
        {
            this.TenKH = "";
            this.MaKH = "";
            this.TaiKhoan = "";
            this.NgayDat = DateTime.Now;
            this.NgayGH = DateTime.Now.AddDays(2);
            this.DiaChiGH = "";
            this.SanPhamDC = new SortedList<string, CtDonHang>();
        }
        //---List; ArrayList; SortedList; MashMap;,,,,
        //--- SortedList; ...<key> - <Value>
        /// <summary>
        /// Phương thức trả về true nếu không có sản phẩm nào đã chọn mua trong hệ thống
        /// </summary>
        public SortedList<string, CtDonHang> SanPhamDC { get; set; }
        public bool IsEmpty()
        {
            return SanPhamDC.Keys.Count == 0;
        }
        /// <summary>
        /// Phương thức thêm một sản phẩm đã chọn mua vào giỏ hàng
        /// Có 2 tình huống
        /// </summary>
        /// <param name="MaSP"></param>
        public void addItem( string MaSP)
        {
            if (SanPhamDC.Keys.Contains(MaSP))
            {
                //--- Trỏ đến sản phẩm cần thay đổi số lượng mua có từ trong giỏ hàng -  IndexOfKey chỉ ra vị trí thứ mấy  
                CtDonHang x = SanPhamDC.Values[SanPhamDC.IndexOfKey(MaSP)];
                //--- Tăng số lượng lên 1
                x.SoLuong++;;
            }
            else
            {
                //--- Tạo 1 object chi tiết đơn hàng mới
                CtDonHang i = new CtDonHang();
                //--- Cập nhật thông tin hiện hành từ hệ thống cho đối tượng
                i.MaSP = MaSP;
                i.SoLuong = 1;
                //--- Lấy giá bán, giảm giá từ table Sản Phẩm
                SanPham z = Common.GetProdutsById(MaSP);
                i.GiaBan = z.GiaBan;
                i.GiamGia = z.GiamGia;
                //---Bỏ vào danh sách các sản phẩm đã chọn mua trong giỏ hàng
                SanPhamDC.Add(MaSP, i);
            }
        }
        
        /// <summary>
        /// Xóa 1 sản phẩm trong giỏ hàng 
        /// </summary>
        /// <param name="MaSP"></param>
        public void deleteItem(string MaSP)
        {
            if(SanPhamDC.Keys.Contains(MaSP))
            {
                SanPhamDC.Remove(MaSP);
            }
        }
        /// <summary>
        /// Cho phép giảm số lượng hoặc xóa sản phẩm đã chọn khỏi danh sách của giỏ hàng 
        /// </summary>
        /// <param name="MaSP"></param>
        public void decrease(string MaSP)
        {
            if (SanPhamDC.Keys.Contains(MaSP))
            {
                //--- trỏ đến sản phẩm cần thay đổi số lượng mua trong giỏ hàng 
                CtDonHang x = SanPhamDC.Values[SanPhamDC.IndexOfKey(MaSP)];
                if (x.SoLuong > 1)
                {
                    x.SoLuong--;
                }
                else
                {
                    deleteItem(MaSP);
                }      
            }
        }
        /// <summary>
        /// Tính giả trị tiền của một mặt hàng trong giỏ hàng
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public long moneyOfOneProduct(CtDonHang x)
        {
            return (long)((((x.GiaBan * x.SoLuong) - ((x.GiaBan - x.SoLuong) * (x.GiamGia / 100))) *80)/100);
        }
        /// <summary>
        /// Tính tổng thành tiền cho toàn bộ giỏ hàng
        /// </summary>
        /// <returns></returns>
        public long totalOfCartShop()
        {
            long kq = 0;
            foreach (CtDonHang i in SanPhamDC.Values)
                kq += moneyOfOneProduct(i);
            return kq;
        }
       
    }
}