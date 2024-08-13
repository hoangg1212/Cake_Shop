using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
namespace CoSoKTPM.App_Start
{
    public class BundleConfig
    {
        public static void BundleRegister(BundleCollection bundle)
        {
            //--- Add style CSS to bundle for public pages ----
            bundle.Add(new StyleBundle("~/bundles/css1").Include("~/Content/css/bootstrap.min.css",
                                                                 "~/Content/css/style.css",
                                                                 "~/Content/css/responsive.css",
                                                                 "~/Content/css/custom.css",
                                                                 "~/Content/vendor/font-awesome.min.css",
                                                                 "~/Areas/PrivatePages/Content/css/font-awesome.min.css",
                                                                 "~/Areas/PrivatePages/Content/css/ionicons.min.css",
                                                                 "~/Areas/PrivatePages/Content/css/skins/_all-skins.min.css"
                                                                 ));
            //--- Add style CSS to bundle for Private pages ----
            bundle.Add(new StyleBundle("~/bundles/css2").Include("~/Areas/PrivatePages/Content/vendor/pg-calendar/css/pignose.calendar.min.css",
                                                                 "~/Areas/PrivatePages/Content/vendor/chartist/css/chartist.min.css",
                                                                 "~/Areas/PrivatePages/Content/vendor/datatables/css/jquery.dataTables.min.css",
                                                                 "~/Areas/PrivatePages/Content/css/style.css",
                                                                 "~/Areas/PrivatePages/Content/vendor/summernote/summernote.css"
                                                                 ));
            //--- Add style Script to the bundle for Public pages ----
            bundle.Add(new ScriptBundle("~/bundle/scripts1").Include("~/Content/js/jquery-3.2.1.min.js",
                                                                     "~/Content/js/popper.min.js",
                                                                     "~/Content/js/bootstrap.min.js",
                                                                     "~/Content/js/jquery.superslides.min.js",
                                                                     "~/Content/js/bootstrap-select.js",
                                                                     "~/Content/js/inewsticker.js",
                                                                     "~/Content/js/bootsnav.js",
                                                                     "~/Content/js/images-loded.min.js",
                                                                     "~/Content/js/isotope.min.js",
                                                                     "~/Content/js/owl.carousel.min.js",
                                                                     "~/Content/js/baguetteBox.min.js",
                                                                     "~/Content/js/form-validator.min.js",
                                                                     "~/Content/js/contact-form-script.js",
                                                                     "~/Content/js/custom.js",
                                                                     "~/Areas/PrivatePages/Content/js/jquery.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/bootstrap.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/fastclick.js",
                                                                     "~/Areas/PrivatePages/Content/js/adminlte.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/demo.js"
                                                                    ));
            //--- Add style Script to the bundle for Private pages ----
            bundle.Add(new ScriptBundle("~/bundle/scripts2").Include("~/Areas/PrivatePages/Content/vendor/global/global.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/quixnav-init.js",
                                                                     "~/Areas/PrivatePages/Content/js/custom.min.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/chartist/js/chartist.min.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/moment/moment.min.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/pg-calendar/js/pignose.calendar.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/dashboard/dashboard-2.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/datatables/js/jquery.dataTables.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/plugins-init/datatables.init.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/summernote/js/summernote.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/plugins-init/summernote-init.js",
                                                                     "~/Areas/PrivatePages/Content/vendor/jquery-validation/jquery.validate.min.js",
                                                                     "~/Areas/PrivatePages/Content/js/plugins-init/jquery.validate-init.js" 
                                                                   ));

        }
    }
}