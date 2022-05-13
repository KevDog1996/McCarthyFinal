using Microsoft.VisualStudio.TestTools.UnitTesting;
using course_manager.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static course_manager.Controllers.StudentsController;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using course_manager.Data;
using course_manager.Models;


namespace course_manager.Controllers.Tests
{
    [TestClass()]
    public class StudentsControllerTests
    {
        [TestMethod()]
        public void GetStudentsTest()
        {
            
        }
    }
}