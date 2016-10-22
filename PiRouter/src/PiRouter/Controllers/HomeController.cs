using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace PiRouter.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Error()
        {
            return View();
        }

        [Route("hello")]
        [HttpGet]
        public string Hello()
        {
            return "shut your fucking face uncle fucker!";
        }

        [Route("execute/{command}")]
        [HttpGet]
        public void DoIt(string command)
        {
            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = "/bin/bash",
                Arguments = "/bin/hostname && /bin/uname",
                UseShellExecute = false,
                RedirectStandardOutput = true
            };

            Process proc = new Process
            {
                StartInfo = psi
            };

            proc.Start();
        }
    }
}
