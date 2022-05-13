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
    public class AssignmentsController : ControllerBase
    {
        private readonly course_managerContext _context;
        private readonly JwtAuthenticationManager jwtAuthenticationManager;

        public AssignmentsController(JwtAuthenticationManager jwtAuthenticationManager, course_managerContext _context)
        {
            this.jwtAuthenticationManager = jwtAuthenticationManager;
            this._context = _context;
        }

        // GET: api/Assignments
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Assignment>>> GetAssignments()
        {
          if (_context.Assignments == null)
          {
              return NotFound();
          }
            return await _context.Assignments.ToListAsync();
        }

        // GET: api/Assignments/5
        [Authorize(Roles = "Student,Teacher")]
        [HttpGet("{id}")]
        public async Task<ActionResult<Assignment>> GetAssignment(int id)
        {
          if (_context.Assignments == null)
          {
              return NotFound();
          }
            var assignment = await _context.Assignments.FindAsync(id);

            if (assignment == null)
            {
                return NotFound();
            }

            return assignment;
        }

        // PUT: api/Assignments/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAssignment(int id, Assignment assignment)
        {
            if (id != assignment.AssignmentId)
            {
                return BadRequest();
            }

            _context.Entry(assignment).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssignmentExists(id))
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

        // POST: api/Assignments
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [Authorize(Roles = "Teacher")]
        [HttpPost]
        public async Task<ActionResult<Assignment>> PostAssignment(Assignment assignment)
        {
          if (_context.Assignments == null)
          {
              return Problem("Entity set 'course_managerContext.Assignments'  is null.");
          }
            _context.Assignments.Add(assignment);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (AssignmentExists(assignment.AssignmentId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetAssignment", new { id = assignment.AssignmentId }, assignment);
        }

        // DELETE: api/Assignments/5
        [Authorize(Roles = "Teacher")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAssignment(int id)
        {
            if (_context.Assignments == null)
            {
                return NotFound();
            }
            var assignment = await _context.Assignments.FindAsync(id);
            if (assignment == null)
            {
                return NotFound();
            }

            _context.Assignments.Remove(assignment);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        //Authorize
        [AllowAnonymous]
        [HttpPost("Authorize")]
        public IActionResult AuthUser([FromBody] User_Assignment usr)
        {
            var token = jwtAuthenticationManager.Authenticate(usr.username, usr.password, usr.role);
            if (token == null)
            {
                return Unauthorized();
            }
            return Ok(token);
        }

        //UNAuthorize
        [AllowAnonymous]
        [HttpPost("UnAuthorize")]
        public IActionResult UnAuthUser([FromBody] User_Assignment usr)
        {
            var token = jwtAuthenticationManager.Authenticate(usr.username, usr.password, usr.role);
            if (token == null)
            {
                return Ok(token);
            }
            token = null;
            return Unauthorized();
        }

        private bool AssignmentExists(int id)
        {
            return (_context.Assignments?.Any(e => e.AssignmentId == id)).GetValueOrDefault();
        }

        public class User_Assignment
        {
            public string username { get; set; }
            public string password { get; set; }
            public string role { get; set; }
        }

    }
}
