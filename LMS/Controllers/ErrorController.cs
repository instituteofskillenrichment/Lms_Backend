using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace LMS.Controllers
{
    public class ErrorController : Controller
    {
        private readonly ILogger<ErrorController> logger;
        public ErrorController(ILogger<ErrorController> logger)
        {
            this.logger = logger;
        }

        [Route("Error")]
        [AllowAnonymous]
        public IActionResult Error()
        {
            var exceptionDetails = HttpContext.Features.Get<IExceptionHandlerPathFeature>();

            logger.LogError($"The path {exceptionDetails.Path} threw an exception " +
                $"The message is {exceptionDetails.Error.Message}. " + $"Stack trace is {exceptionDetails.Error.StackTrace}");

            ViewBag.ExceptionPath = exceptionDetails.Path;
            ViewBag.ExceptionMessage = exceptionDetails.Error.Message;
            ViewBag.StackTrace = exceptionDetails.Error.StackTrace;

            return View("Error");
        }

    }
}