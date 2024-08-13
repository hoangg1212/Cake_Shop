using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CoSoKTPM.Models;

namespace CoSoKTPM.Controllers
{
    public class ArticleContentController : Controller
    {
        // GET: ArticleContent
        public ActionResult Index( string maBV)
        {
            CoSoKTPMConnect db = new CoSoKTPMConnect();
            BaiViet x = db.BaiViets.Where(z => z.MaBV == maBV).First<BaiViet>();
            ViewData["BaiCanXem"] = x;
            return View();
        }
    }
}