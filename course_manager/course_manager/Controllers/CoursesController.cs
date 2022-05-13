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
    public class CoursesController : ControllerBase
    {
        private readonly course_managerContext _context;
        private readonly JwtAuthenticationManager jwtAuthenticationManager;

        public CoursesController(JwtAuthenticationManager jwtAuthenticationManager, course_managerContext _context)
        {
            this.jwtAuthenticationManager = jwtAuthenticationManager;
            this._context = _context;
        }

        // GET: api/Courses
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Course>>> GetCourses()
        {
          if (_context.Courses == null)
          {
              return NotFound();
          }
            return await _context.Courses.ToListAsync();
        }

        // GET: api/Courses/5
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Course>> GetCourse(int id)
        {
          if (_context.Courses == null)
          {
              return NotFound();
          }
            var course = await _context.Courses.FindAsync(id);

            if (course == null)
            {
                return NotFound();
            }

            return course;
        }

        // PUT: api/Courses/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCourse(int id, Course course)
        {
            if (id != course.CourseId)
            {
                return BadRequest();
            }

            _context.Entry(course).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CourseExists(id))
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

        // POST: api/Courses
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPost]

        public async Task<ActionResult<Course>> PostCourse(Course course)
        {
          if (_context.Courses == null)
          {
              return Problem("Entity set 'course_managerContext.Courses'  is null.");
          }
            _context.Courses.Add(course);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CourseExists(course.CourseId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetCourse", new { id = course.CourseId }, course);
        }

        // DELETE: api/Courses/5
        [Authorize(Roles = "Teacher")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCourse(int id)
        {
            if (_context.Courses == null)
            {
                return NotFound();
            }
            var course = await _context.Courses.FindAsync(id);
            if (course == null)
            {
                return NotFound();
            }

            _context.Courses.Remove(course);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        //Authorize
        [AllowAnonymous]
        [HttpPost("Authorize")]
        public IActionResult AuthUser([FromBody] User_Courses usr)
        {
            var token = jwtAuthenticationManager.Authenticate(usr.username, usr.password, usr.role);
            if (token == null)
            {
                return Unauthorized();
            }
            return Ok(token);
        }

        private bool CourseExists(int id)
        {
            return (_context.Courses?.Any(e => e.CourseId == id)).GetValueOrDefault();
        }

        public class User_Courses
        {
            public string username { get; set; }
            public string password { get; set; }
            public string role { get; set; }
        }

    }
}
