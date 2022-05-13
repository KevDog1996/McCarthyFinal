USE [master]
GO
/****** Object:  Database [course_manager]    Script Date: 5/12/2022 11:54:57 PM ******/
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
/****** Object:  Table [dbo].[assignment]    Script Date: 5/12/2022 11:54:57 PM ******/
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
/****** Object:  Table [dbo].[courses]    Script Date: 5/12/2022 11:54:57 PM ******/
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
/****** Object:  Table [dbo].[students]    Script Date: 5/12/2022 11:54:57 PM ******/
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
/****** Object:  Table [dbo].[students_courses]    Script Date: 5/12/2022 11:54:57 PM ******/
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
/****** Object:  Table [dbo].[teachers]    Script Date: 5/12/2022 11:54:57 PM ******/
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
