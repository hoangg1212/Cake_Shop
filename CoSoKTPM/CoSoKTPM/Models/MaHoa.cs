using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Security.Cryptography;
using System.Text;

namespace CoSoKTPM.Models
{
    public class MaHoa
    {
        //-- Hàm phục vụ mã hóa một chuỗi văn bản gốc dựa vào việc băm dữ liệu bởi SHA256
        //-- PlainText là chuỗi văn bản muốn mã hóa
        //-- Returns là kết quả đã mã hóa
        public static string encrytSHA256(string PlainText)
        {
            string result = "";
            //-- Create a SHA256 object --
            using (SHA256 bb = SHA256.Create())
            {
                //-- Convert plain text to a bytes array
                byte[] sourceData = Encoding.UTF8.GetBytes(PlainText);
                //-- Compute Hash and return a byte array 
                byte[] hashResult = bb.ComputeHash(sourceData);
                result = BitConverter.ToString(hashResult);
            }
            return result;
        }
    }
}