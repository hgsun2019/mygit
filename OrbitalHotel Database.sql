USE [master]
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'OrbitalHotel')
BEGIN
CREATE DATABASE [OrbitalHotel] ON  PRIMARY 
END
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'OrbitalHotel', @new_cmptlevel=90
GO
ALTER DATABASE [OrbitalHotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OrbitalHotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OrbitalHotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OrbitalHotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OrbitalHotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [OrbitalHotel] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [OrbitalHotel] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [OrbitalHotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OrbitalHotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OrbitalHotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OrbitalHotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OrbitalHotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OrbitalHotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OrbitalHotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OrbitalHotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OrbitalHotel] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OrbitalHotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OrbitalHotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OrbitalHotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OrbitalHotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OrbitalHotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OrbitalHotel] SET  READ_WRITE 
GO
ALTER DATABASE [OrbitalHotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OrbitalHotel] SET  MULTI_USER 
GO
ALTER DATABASE [OrbitalHotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OrbitalHotel] SET DB_CHAINING OFF 
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'OrbitalHotel')
CREATE LOGIN [OrbitalHotel] WITH PASSWORD=N'W§ô?j?ÿÙ½Ü&è"¸[Æd×¼=Ò\?³a	ø§', DEFAULT_DATABASE=[OrbitalHotel], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
ALTER LOGIN [OrbitalHotel] DISABLE
GO
USE [OrbitalHotel]
GO
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OrbitalHotel')
CREATE USER [OrbitalHotel] FOR LOGIN [OrbitalHotel] WITH DEFAULT_SCHEMA=[OrbitalHotel]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'OrbitalHotel')
EXEC sys.sp_executesql N'CREATE SCHEMA [OrbitalHotel] AUTHORIZATION [OrbitalHotel]'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[AvailableRooms]'))
EXEC dbo.sp_executesql @statement = N'  CREATE View [OrbitalHotel].[AvailableRooms] AS    SELECT     RoomID, Type, Number, Occupancy, Price, Available, Description  FROM         Room  WHERE     (Available = 1)          ' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_SelectAll]
AS
	SET NOCOUNT ON;
SELECT     RoomID, Type, Number, Occupancy, Price, Available, Description
FROM         Room' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[User]') AND type in (N'U'))
BEGIN
CREATE TABLE [OrbitalHotel].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Type] [varchar](255) NOT NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF__User__Active__2A4B4B5E]  DEFAULT ((1)),
 CONSTRAINT [User_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_Delete]
(
	@Original_RoomID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Room] WHERE (([RoomID] = @Original_RoomID))' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_SelectImage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_SelectImage]
(
	@RoomID int
)
AS
	SET NOCOUNT ON;
SELECT     Image
FROM         Room
WHERE     (RoomID = @RoomID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_SelectByRoomID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_SelectByRoomID]
(
	@RoomID int
)
AS
	SET NOCOUNT ON;
SELECT     RoomID,Type, Number, Occupancy, Price, Available, Description
FROM         Room
WHERE     (RoomID = @RoomID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room]') AND type in (N'U'))
BEGIN
CREATE TABLE [OrbitalHotel].[Room](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](255) NOT NULL,
	[Number] [int] NOT NULL,
	[Occupancy] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Available] [bit] NOT NULL,
	[Description] [varchar](8000) NULL,
	[Image] [image] NULL,
 CONSTRAINT [Room_PK] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Guest]') AND type in (N'U'))
BEGIN
CREATE TABLE [OrbitalHotel].[Guest](
	[GuestID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[Phone] [varchar](255) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[CardNumber] [varchar](255) NOT NULL,
	[UserID] [int] NULL,
 CONSTRAINT [Guest_PK] PRIMARY KEY CLUSTERED 
(
	[GuestID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation]') AND type in (N'U'))
BEGIN
CREATE TABLE [OrbitalHotel].[Reservation](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[RoomID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GuestID] [int] NOT NULL,
	[Arrival] [datetime] NOT NULL,
	[Nights] [int] NOT NULL,
	[Adults] [int] NULL CONSTRAINT [DF__Reservati__Adult__2F10007B]  DEFAULT ((0)),
	[Teenagers] [int] NULL CONSTRAINT [DF__Reservati__Teena__300424B4]  DEFAULT ((0)),
	[Children] [int] NULL CONSTRAINT [DF__Reservati__Child__30F848ED]  DEFAULT ((0)),
	[Pets] [int] NULL CONSTRAINT [DF__Reservatio__Pets__31EC6D26]  DEFAULT ((0)),
	[CanceledByUserID] [int] NULL,
 CONSTRAINT [Reservation_PK] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Guest_GetByUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Guest_GetByUserId]
(
	@UserID int
)
AS
	SET NOCOUNT ON;
SELECT     Guest.GuestID, Guest.UserID, Guest.FirstName, Guest.LastName, Guest.Address, Guest.City, Guest.ZipCode, Guest.State, Guest.Country, 
                      Guest.Phone, Guest.Email, Guest.CardNumber, [User].UserName, [User].Type, [User].Active
FROM         Guest INNER JOIN
                      [User] ON Guest.UserID = [User].UserID
WHERE     (Guest.UserID = @UserID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Guest_AddNew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Guest_AddNew]
(
	@Username varchar(255),
	@Password varchar(255),
	@Type	varchar(255),
	@Active bit,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Address nvarchar(255),
	@City nvarchar(50),
	@ZipCode varchar(50),
	@State nvarchar(50),
	@Country varchar(255),
	@Phone varchar(255),
	@Email varchar(255),
	@CardNumber varchar(255)
)
AS
	SET NOCOUNT OFF;

DECLARE @UserID int;
	
BEGIN TRANSACTION
	
INSERT INTO [User]
	(Username, Password, Type, Active)
	VALUES (@Username,@Password,@Type,@Active);
	
SET @UserID=SCOPE_IDENTITY();
	
INSERT INTO Guest
                      (FirstName, LastName, Address, City, ZipCode, State, Country, Phone, Email, CardNumber, UserID)
VALUES     (@FirstName,@LastName,@Address,@City,@ZipCode,@State,@Country,@Phone,@Email,@CardNumber,@UserID)

COMMIT TRANSACTION

SELECT @UserID;' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Guest_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Guest_SelectAll]
AS
	SET NOCOUNT ON;
SELECT     Guest.GuestID, Guest.UserID, Guest.FirstName, Guest.LastName, Guest.Address, Guest.City, Guest.ZipCode, Guest.State, Guest.Country, 
                      Guest.Phone, Guest.Email, Guest.CardNumber, [User].UserName, [User].Type, [User].Active
FROM         Guest INNER JOIN
                      [User] ON Guest.UserID = [User].UserID' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_GetByPeriod]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_GetByPeriod]
	
	(
	@StartDate DateTime,
	@EndDate DateTime
	)
	
AS

DECLARE @CheckInHour int;
SET @CheckInHour=15;

SELECT     RoomID, Type, Number, Occupancy, Price, Available, Description
FROM         OrbitalHotel.Room
WHERE     (RoomID NOT IN
                          (SELECT     OrbitalHotel.Room.RoomID
                            FROM          OrbitalHotel.Room INNER JOIN
                                                   OrbitalHotel.Reservation ON OrbitalHotel.Room.RoomID = OrbitalHotel.Reservation.RoomID
                            WHERE      (Reservation.CanceledByUserID IS NULL) AND
                             (
                             (OrbitalHotel.Reservation.Arrival BETWEEN DATEADD(Hour,@CheckInHour,@StartDate) AND @EndDate) OR
                             (DATEADD(Day, OrbitalHotel.Reservation.Nights, OrbitalHotel.Reservation.Arrival) BETWEEN DATEADD(Hour,@CheckInHour,@StartDate) AND @EndDate) OR
                             (DATEADD(Hour,@CheckInHour,@StartDate) BETWEEN OrbitalHotel.Reservation.Arrival AND DATEADD(Day, OrbitalHotel.Reservation.Nights, OrbitalHotel.Reservation.Arrival)) OR
                             (@EndDate BETWEEN OrbitalHotel.Reservation.Arrival AND DATEADD(Day, OrbitalHotel.Reservation.Nights, OrbitalHotel.Reservation.Arrival))
                              
                                                   )))
                                                   ORDER BY Number


	/* SET NOCOUNT ON */ 
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_SelectAll]
AS
	SET NOCOUNT ON;
SELECT     Reservation.ReservationID, Reservation.GuestID, Reservation.UserID, Reservation.RoomID, Room.Number AS RoomNumber, Room.Occupancy, 
                      Room.Price, Reservation.Arrival, Reservation.Nights, Reservation.Adults, Reservation.Teenagers, Reservation.Children, Reservation.Pets, 
                      Reservation.CanceledByUserID
FROM         Reservation INNER JOIN
                      Room ON Reservation.RoomID = Room.RoomID' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_AddNew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_AddNew]
(
	@RoomID int,
	@UserID int,
	@GuestID int,
	@ArrivalDate datetime,
	@Nights int,
	@Adults int,
	@Teenagers int,
	@Children int,
	@Pets int
)
AS
	SET NOCOUNT OFF;
INSERT INTO Reservation
                      (RoomID, UserID, GuestID, Arrival, Nights, Adults, Teenagers, Children, Pets)
VALUES     (@RoomID,@UserID,@GuestID,@ArrivalDate,@Nights,@Adults,@Teenagers,@Children,@Pets)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_Cancel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_Cancel]
(
	@CanceledByUserID int,
	@ReservationID int
)
AS
	SET NOCOUNT OFF;
UPDATE    Reservation
SET              CanceledByUserID = @CanceledByUserID
WHERE     (ReservationID = @ReservationID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_SelectHistoryByGuest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [OrbitalHotel].[Reservation_SelectHistoryByGuest]
(
	@GuestID int
)
AS
	SET NOCOUNT ON;
SELECT     Reservation.ReservationID, Reservation.GuestID, Reservation.UserID, Reservation.RoomID, Room.Number AS RoomNumber, Room.Occupancy, 
                      Room.Price, Reservation.Arrival, Reservation.Nights, Reservation.Adults, Reservation.Teenagers, Reservation.Children, Reservation.Pets, 
                      Reservation.CanceledByUserID, Room.Price * Reservation.Nights AS TotalPrice
FROM         Reservation INNER JOIN
                      Room ON Reservation.RoomID = Room.RoomID
WHERE     (Reservation.GuestID = @GuestID) AND (Reservation.CanceledByUserID IS NULL) AND (Reservation.Arrival<
CONVERT(datetime,CONVERT(varchar,DATEPART(month,GETDATE()))+''/''+CONVERT(varchar,DATEPART(day,GETDATE()))+''/''+CONVERT(varchar,DATEPART(year,GETDATE()),101)))
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_SelectPendingByGuest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_SelectPendingByGuest]
(
	@GuestID int
)
AS
	SET NOCOUNT ON;
SELECT     Reservation.ReservationID, Reservation.GuestID, Reservation.UserID, Reservation.RoomID, Room.Number AS RoomNumber, Room.Occupancy, 
                      Room.Price, Reservation.Arrival, Reservation.Nights, Reservation.Adults, Reservation.Teenagers, Reservation.Children, Reservation.Pets, 
                      Reservation.CanceledByUserID, Room.Price * Reservation.Nights AS TotalPrice
FROM         Reservation INNER JOIN
                      Room ON Reservation.RoomID = Room.RoomID
WHERE     (Reservation.GuestID = @GuestID) AND (Reservation.CanceledByUserID IS NULL) AND (Reservation.Arrival>
CONVERT(datetime,CONVERT(varchar,DATEPART(month,GETDATE()))+''/''+CONVERT(varchar,DATEPART(day,GETDATE()))+''/''+CONVERT(varchar,DATEPART(year,GETDATE()),101)))' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_SelectCanceledByGuest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_SelectCanceledByGuest]
(
	@GuestID int
)
AS
	SET NOCOUNT ON;
SELECT     Reservation.ReservationID, Reservation.GuestID, Reservation.UserID, Reservation.RoomID, Room.Number AS RoomNumber, Room.Occupancy, 
                      Room.Price, Reservation.Arrival, Reservation.Nights, Reservation.Adults, Reservation.Teenagers, Reservation.Children, Reservation.Pets, 
                      Reservation.CanceledByUserID
FROM         Reservation INNER JOIN
                      Room ON Reservation.RoomID = Room.RoomID
WHERE     (Reservation.GuestID = @GuestID) AND (Reservation.CanceledByUserID IS NOT NULL)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation_SelectAllByGuest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Reservation_SelectAllByGuest]
(
	@GuestID int
)
AS
	SET NOCOUNT ON;
SELECT     Reservation.ReservationID, Reservation.GuestID, Reservation.UserID, Reservation.RoomID, Room.Number AS RoomNumber, Room.Occupancy, 
                      Room.Price, Reservation.Arrival, Reservation.Nights, Reservation.Adults, Reservation.Teenagers, Reservation.Children, Reservation.Pets, 
                      Reservation.CanceledByUserID, Room.Price * Reservation.Nights AS TotalPrice
FROM         Reservation INNER JOIN
                      Room ON Reservation.RoomID = Room.RoomID
WHERE     (Reservation.GuestID = @GuestID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_Insert]
(
	@Type varchar(255),
	@Number int,
	@Occupancy int,
	@Price money,
	@Available bit,
	@Description varchar(8000)
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Room] ([Type], [Number], [Occupancy], [Price], [Available], [Description]) VALUES (@Type, @Number, @Occupancy, @Price, @Available, @Description);
	
SELECT RoomID, Type, Number, Occupancy, Price, Available, Description FROM Room WHERE (RoomID = SCOPE_IDENTITY())' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_Update]
(
	@Type varchar(255),
	@Number int,
	@Occupancy int,
	@Price money,
	@Available bit,
	@Description varchar(8000),
	@Original_RoomID int,
	@RoomID int
)
AS
	SET NOCOUNT OFF;
UPDATE [Room] SET [Type] = @Type, [Number] = @Number, [Occupancy] = @Occupancy, [Price] = @Price, [Available] = @Available, [Description] = @Description WHERE (([RoomID] = @Original_RoomID));
	
SELECT RoomID, Type, Number, Occupancy, Price, Available, Description FROM Room WHERE (RoomID = @RoomID)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_UpdateImage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [OrbitalHotel].[Room_UpdateImage]
(
	@Image image,
	@RoomID int
)
AS
	SET NOCOUNT OFF;
UPDATE    Room
SET              Image = @Image
WHERE     (RoomID = @RoomID)' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[User_Guest_FK1]') AND parent_object_id = OBJECT_ID(N'[OrbitalHotel].[Guest]'))
ALTER TABLE [OrbitalHotel].[Guest]  WITH CHECK ADD  CONSTRAINT [User_Guest_FK1] FOREIGN KEY([UserID])
REFERENCES [OrbitalHotel].[User] ([UserID])
GO
ALTER TABLE [OrbitalHotel].[Guest] CHECK CONSTRAINT [User_Guest_FK1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Guest_Reservation_FK1]') AND parent_object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation]'))
ALTER TABLE [OrbitalHotel].[Reservation]  WITH CHECK ADD  CONSTRAINT [Guest_Reservation_FK1] FOREIGN KEY([GuestID])
REFERENCES [OrbitalHotel].[Guest] ([GuestID])
GO
ALTER TABLE [OrbitalHotel].[Reservation] CHECK CONSTRAINT [Guest_Reservation_FK1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[Room_Reservation_FK1]') AND parent_object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation]'))
ALTER TABLE [OrbitalHotel].[Reservation]  WITH CHECK ADD  CONSTRAINT [Room_Reservation_FK1] FOREIGN KEY([RoomID])
REFERENCES [OrbitalHotel].[Room] ([RoomID])
GO
ALTER TABLE [OrbitalHotel].[Reservation] CHECK CONSTRAINT [Room_Reservation_FK1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[User_Reservation_FK1]') AND parent_object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation]'))
ALTER TABLE [OrbitalHotel].[Reservation]  WITH CHECK ADD  CONSTRAINT [User_Reservation_FK1] FOREIGN KEY([UserID])
REFERENCES [OrbitalHotel].[User] ([UserID])
GO
ALTER TABLE [OrbitalHotel].[Reservation] CHECK CONSTRAINT [User_Reservation_FK1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[OrbitalHotel].[User_Reservation_FK2]') AND parent_object_id = OBJECT_ID(N'[OrbitalHotel].[Reservation]'))
ALTER TABLE [OrbitalHotel].[Reservation]  WITH CHECK ADD  CONSTRAINT [User_Reservation_FK2] FOREIGN KEY([CanceledByUserID])
REFERENCES [OrbitalHotel].[User] ([UserID])
GO
ALTER TABLE [OrbitalHotel].[Reservation] CHECK CONSTRAINT [User_Reservation_FK2]
