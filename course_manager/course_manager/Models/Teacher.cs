﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace course_manager.Models
{
    public partial class Teacher
    {
        public Teacher()
        {
            Courses = new HashSet<Course>();
        }

        public int TeacherId { get; set; }
        public string TeacherFirstname { get; set; }
        public string TeacherLastname { get; set; }
        public string TeacherEmail { get; set; }
        public string TeacherPhone { get; set; }

        public virtual ICollection<Course> Courses { get; set; }
    }
}