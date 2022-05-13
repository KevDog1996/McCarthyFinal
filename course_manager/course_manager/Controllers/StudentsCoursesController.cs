using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using course_manager.Data;
using course_manager.Models;

namespace course_manager.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StudentsCoursesController : ControllerBase
    {
        private readonly course_managerContext _context;
        private readonly JwtAuthenticationManager jwtAuthenticationManager;

        public StudentsCoursesController(JwtAuthenticationManager jwtAuthenticationManager, course_managerContext _context)
        {
            this.jwtAuthenticationManager = jwtAuthenticationManager;
            this._context = _context;
        }

        // GET: api/StudentsCourses
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<StudentsCourse>>> GetStudentsCourses()
        {
          if (_context.StudentsCourses == null)
          {
              return NotFound();
          }
            return await _context.StudentsCourses.ToListAsync();
        }

        // GET: api/StudentsCourses/5
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet("{id}")]
        public async Task<ActionResult<StudentsCourse>> GetStudentsCourse(int id)
        {
          if (_context.StudentsCourses == null)
          {
              return NotFound();
          }
            var studentsCourse = await _context.StudentsCourses.FindAsync(id);

            if (studentsCourse == null)
            {
                return NotFound();
            }

            return studentsCourse;
        }

        // PUT: api/StudentsCourses/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutStudentsCourse(int id, StudentsCourse studentsCourse)
        {
            if (id != studentsCourse.StudentCoursesId)
            {
                return BadRequest();
            }

            _context.Entry(studentsCourse).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!StudentsCourseExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/StudentsCourses
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPost]
        public async Task<ActionResult<StudentsCourse>> PostStudentsCourse(StudentsCourse studentsCourse)
        {
          if (_context.StudentsCourses == null)
          {
              return Problem("Entity set 'course_managerContext.StudentsCourses'  is null.");
          }
            _context.StudentsCourses.Add(studentsCourse);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (StudentsCourseExists(studentsCourse.StudentCoursesId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetStudentsCourse", new { id = studentsCourse.StudentCoursesId }, studentsCourse);
        }

        // DELETE: api/StudentsCourses/5
        [Authorize(Roles = "Teacher")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteStudentsCourse(int id)
        {
            if (_context.StudentsCourses == null)
            {
                return NotFound();
            }
            var studentsCourse = await _context.StudentsCourses.FindAsync(id);
            if (studentsCourse == null)
            {
                return NotFound();
            }

            _context.StudentsCourses.Remove(studentsCourse);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        //Authorize
        [AllowAnonymous]
        [HttpPost("Authorize")]
        public IActionResult AuthUser([FromBody] User_Students_Courses usr)
        {
            var token = jwtAuthenticationManager.Authenticate(usr.username, usr.password, usr.role);
            if (token == null)
            {
                return Unauthorized();
            }
            return Ok(token);
        }

        private bool StudentsCourseExists(int id)
        {
            return (_context.StudentsCourses?.Any(e => e.StudentCoursesId == id)).GetValueOrDefault();
        }

        public class User_Students_Courses
        {
            public string username { get; set; }
            public string password { get; set; }
            public string role { get; set; }
        }
    }
}
