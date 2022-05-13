using Microsoft.VisualStudio.TestTools.UnitTesting;
using course_manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static course_manager.Controllers.StudentsController;

namespace course_manager.Tests
{
    [TestClass()]
    public class JwtAuthenticationManagerTests
    {
        [TestMethod()]
        public void AuthenticateTest()
        {
            JwtAuthenticationManager manager = new JwtAuthenticationManager("fakeKeyNotLogin111");

            User user = new User
            {
                username = "testUsername",
                password = "testpassword!!!",
                role = "testrole"
            };

            var ret = manager.Authenticate(user.username, user.password, user.role);

            Assert.IsNull(ret);

        }

        [TestMethod()]
        public void AuthenticateTest_Throws()
        {
            JwtAuthenticationManager manager = new JwtAuthenticationManager("compRepairTestKey$$$");

            User user = new User
            {
                username = "test",
                password = "password",
                role = "Student"
            };

            var ret = manager.Authenticate(user.username, user.password, user.role);

            Assert.IsNotNull(ret);

        }
    }
}