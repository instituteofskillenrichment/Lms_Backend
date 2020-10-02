using LMS.BusinessLogics.Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;

namespace LMS.Common
{
    static public class Utility
    {
        static public string ProcessUploadedFile(dynamic model, IHostingEnvironment hostingEnvironment)
        {
            string uniqueFileName = null;
            if (model != null)
            {
                string uploadsFolder = Path.Combine(hostingEnvironment.WebRootPath, "Lectures");
                uniqueFileName = Guid.NewGuid().ToString() + "_" + model.Lecture_File.FileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    model.Lecture_File.CopyTo(fileStream);
                }
            }

            return uniqueFileName;
        }

        
    }
}
