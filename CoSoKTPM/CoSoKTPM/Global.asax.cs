using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using System.Web.Optimization;
using CoSoKTPM.App_Start;

using CoSoKTPM.Models;

namespace CoSoKTPM
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            //--- Registrer your bundle here
            BundleCollection bundles = BundleTable.Bundles;
            BundleConfig.BundleRegister(bundles);
        }
        protected void Session_Start (Object sender, EventArgs e)
        {
            Session["TtDangNhap"] = null;
            //--- Cấp cho người truy cập giỏ hàng chưa có gì cả
            Session["GioHang"] = new CartShop();
        }
    }
}
