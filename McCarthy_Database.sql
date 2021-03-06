USE [master]
GO
/****** Object:  Database [course_manager]    Script Date: 5/13/2022 9:37:41 AM ******/
CREATE DATABASE [course_manager]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'course_manager', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\course_manager.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'course_manager_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\course_manager_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [course_manager] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [course_manager].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [course_manager] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [course_manager] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [course_manager] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [course_manager] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [course_manager] SET ARITHABORT OFF 
GO
ALTER DATABASE [course_manager] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [course_manager] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [course_manager] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [course_manager] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [course_manager] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [course_manager] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [course_manager] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [course_manager] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [course_manager] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [course_manager] SET  DISABLE_BROKER 
GO
ALTER DATABASE [course_manager] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [course_manager] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [course_manager] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [course_manager] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [course_manager] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [course_manager] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [course_manager] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [course_manager] SET RECOVERY FULL 
GO
ALTER DATABASE [course_manager] SET  MULTI_USER 
GO
ALTER DATABASE [course_manager] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [course_manager] SET DB_CHAINING OFF 
GO
ALTER DATABASE [course_manager] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [course_manager] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [course_manager] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [course_manager] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'course_manager', N'ON'
GO
ALTER DATABASE [course_manager] SET QUERY_STORE = OFF
GO
USE [course_manager]
GO
/****** Object:  Table [dbo].[assignment]    Script Date: 5/13/2022 9:37:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assignment](
	[assignment_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[assignment] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[assignment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 5/13/2022 9:37:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[course_id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [int] NOT NULL,
	[course_name] [text] NULL,
	[course_description] [text] NULL,
	[course_credits] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students]    Script Date: 5/13/2022 9:37:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[student_id] [int] IDENTITY(1,1) NOT NULL,
	[student_firstname] [text] NULL,
	[student_lastname] [text] NULL,
	[student_email] [text] NULL,
	[student_phone] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students_courses]    Script Date: 5/13/2022 9:37:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students_courses](
	[students_courses_id] [int] IDENTITY(1,1) NOT NULL,
	[student_id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[students_courses_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teachers]    Script Date: 5/13/2022 9:37:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teachers](
	[teacher_id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_firstname] [text] NULL,
	[teacher_lastname] [text] NULL,
	[teacher_email] [text] NULL,
	[teacher_phone] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[teacher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[assignment] ON 

INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (1, 1, 1, N'test assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (2, 1, 2, N'Another assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (3, 1, 3, N'New assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (4, 2, 1, N'Hard assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (5, 2, 2, N'Easy assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (6, 3, 3, N'medium assignment')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (7, 4, 1, N'paper')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (8, 4, 2, N'paper')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (9, 4, 3, N'fun paper')
INSERT [dbo].[assignment] ([assignment_id], [student_id], [course_id], [assignment]) VALUES (10, 4, 4, N'not fun paper')
SET IDENTITY_INSERT [dbo].[assignment] OFF
GO
SET IDENTITY_INSERT [dbo].[courses] ON 

INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (1, 1, N'CMSC 1212', N'Web Markup Language', 3)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (2, 2, N'MATH 1218', N'College Algebra', 4)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (3, 2, N'CMSC 1217 ', N'Intro to Data Analytics', 3)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (4, 3, N'CMSC 1236', N'Java Programming', 4)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (5, 6, N'CMSC1216', N'Database Modeling I', 4)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (6, 6, N'CMSC 2203', N'Structured Programming Logic', 3)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (7, 5, N'CMSC 2204', N'Mobile Device Programming/Connectivity', 3)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (8, 4, N'CMSC 2201', N'Database Modeling II', 4)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (9, 4, N'CMSC 1255', N'Server-Side Programming', 4)
INSERT [dbo].[courses] ([course_id], [teacher_id], [course_name], [course_description], [course_credits]) VALUES (10, 10, N'CMSC 2279', N'Systems Analysis and Design', 3)
SET IDENTITY_INSERT [dbo].[courses] OFF
GO
SET IDENTITY_INSERT [dbo].[students] ON 

INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (1, N'Cory', N'Kennedy', N'cory@email.com', N'1234567891')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (2, N'Jeremy', N'Kennedy', N'Jeremy@email.com', N'1111111111')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (3, N'Matthew', N'McCarthy', N'Matthew@email.com', N'2222222222')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (4, N'Nathan', N'Carlson', N'Nathan@email.com', N'3333333333')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (5, N'Flynn', N'Bray', N'Flynn@email.com', N'4444444444')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (6, N'Kevin', N'McCarthy', N'Kevin@email.com', N'5555555555')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (7, N'Hengest', N'Druid', N'Hengest@email.com', N'6666666666')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (8, N'Ya', N'Boi', N'Boi@email.com', N'7777777777')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (9, N'Somebody', N'Guy', N'Somebody@email.com', N'8888888888')
INSERT [dbo].[students] ([student_id], [student_firstname], [student_lastname], [student_email], [student_phone]) VALUES (10, N'Marry', N'Owens', N'Marry@email.com', N'9999999999')
SET IDENTITY_INSERT [dbo].[students] OFF
GO
SET IDENTITY_INSERT [dbo].[students_courses] ON 

INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (1, 1, 1)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (2, 1, 2)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (3, 1, 3)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (4, 2, 1)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (5, 2, 2)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (6, 3, 3)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (7, 4, 1)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (8, 4, 2)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (9, 4, 3)
INSERT [dbo].[students_courses] ([students_courses_id], [student_id], [course_id]) VALUES (10, 4, 4)
SET IDENTITY_INSERT [dbo].[students_courses] OFF
GO
SET IDENTITY_INSERT [dbo].[teachers] ON 

INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (1, N'Billy', N'Kennedy', N'Billy@email.com', N'1115558624')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (2, N'Bobby', N'Micheals', N'Bobby@email.com', N'7395268888')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (3, N'Cool', N'Guy', N'Cool@email.com', N'7845214444')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (4, N'Name', N'Lname', N'Name@email.com', N'7773335555')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (5, N'Tim', N'Bray', N'Tim@email.com', N'7779996666')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (6, N'Roy', N'Swanson', N'Roy@email.com', N'7774441111')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (7, N'Pablo', N'Rodrigeuz', N'Pablo@email.com', N'7778882222')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (8, N'Gene', N'Meyers', N'Gene@email.com', N'7778889999')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (9, N'Austin', N'Gonz', N'Austin@email.com', N'7775552222')
INSERT [dbo].[teachers] ([teacher_id], [teacher_firstname], [teacher_lastname], [teacher_email], [teacher_phone]) VALUES (10, N'Maggie', N'Davis', N'Maggie@email.com', N'1237894569')
SET IDENTITY_INSERT [dbo].[teachers] OFF
GO
ALTER TABLE [dbo].[assignment]  WITH CHECK ADD  CONSTRAINT [FK_course_assignment_id] FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([course_id])
GO
ALTER TABLE [dbo].[assignment] CHECK CONSTRAINT [FK_course_assignment_id]
GO
ALTER TABLE [dbo].[assignment]  WITH CHECK ADD  CONSTRAINT [FK_student_assignment_id] FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([student_id])
GO
ALTER TABLE [dbo].[assignment] CHECK CONSTRAINT [FK_student_assignment_id]
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD  CONSTRAINT [FK_teacher_id] FOREIGN KEY([teacher_id])
REFERENCES [dbo].[teachers] ([teacher_id])
GO
ALTER TABLE [dbo].[courses] CHECK CONSTRAINT [FK_teacher_id]
GO
ALTER TABLE [dbo].[students_courses]  WITH CHECK ADD  CONSTRAINT [FK_courses_student] FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([course_id])
GO
ALTER TABLE [dbo].[students_courses] CHECK CONSTRAINT [FK_courses_student]
GO
ALTER TABLE [dbo].[students_courses]  WITH CHECK ADD  CONSTRAINT [FK_student_id_courses] FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([student_id])
GO
ALTER TABLE [dbo].[students_courses] CHECK CONSTRAINT [FK_student_id_courses]
GO
USE [master]
GO
ALTER DATABASE [course_manager] SET  READ_WRITE 
GO
