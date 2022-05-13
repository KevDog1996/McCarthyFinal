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
    public class TeachersController : ControllerBase
    {
        private readonly course_managerContext _context;
        private readonly JwtAuthenticationManager jwtAuthenticationManager;

        public TeachersController(JwtAuthenticationManager jwtAuthenticationManager, course_managerContext _context)
        {
            this.jwtAuthenticationManager = jwtAuthenticationManager;
            this._context = _context;
        }

        // GET: api/Teachers
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Teacher>>> GetTeachers()
        {
          if (_context.Teachers == null)
          {
              return NotFound();
          }
            return await _context.Teachers.ToListAsync();
        }

        // GET: api/Teachers/5
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Teacher>> GetTeacher(int id)
        {
          if (_context.Teachers == null)
          {
              return NotFound();
          }
            var teacher = await _context.Teachers.FindAsync(id);

            if (teacher == null)
            {
                return NotFound();
            }

            return teacher;
        }

        // PUT: api/Teachers/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTeacher(int id, Teacher teacher)
        {
            if (id != teacher.TeacherId)
            {
                return BadRequest();
            }

            _context.Entry(teacher).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TeacherExists(id))
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

        // POST: api/Teachers
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPost]
        public async Task<ActionResult<Teacher>> PostTeacher(Teacher teacher)
        {
          if (_context.Teachers == null)
          {
              return Problem("Entity set 'course_managerContext.Teachers'  is null.");
          }
            _context.Teachers.Add(teacher);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (TeacherExists(teacher.TeacherId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetTeacher", new { id = teacher.TeacherId }, teacher);
        }

        // DELETE: api/Teachers/5
        [Authorize(Roles = "Teacher")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTeacher(int id)
        {
            if (_context.Teachers == null)
            {
                return NotFound();
            }
            var teacher = await _context.Teachers.FindAsync(id);
            if (teacher == null)
            {
                return NotFound();
            }

            _context.Teachers.Remove(teacher);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        //Authorize
        [AllowAnonymous]
        [HttpPost("Authorize")]
        public IActionResult AuthUser([FromBody] User_Teachers usr)
        {
            var token = jwtAuthenticationManager.Authenticate(usr.username, usr.password, usr.role);
            if (token == null)
            {
                return Unauthorized();
            }
            return Ok(token);
        }

        private bool TeacherExists(int id)
        {
            return (_context.Teachers?.Any(e => e.TeacherId == id)).GetValueOrDefault();
        }

        public class User_Teachers
        {
            public string username { get; set; }
            public string password { get; set; }
            public string role { get; set; }    
        }

    }
}
