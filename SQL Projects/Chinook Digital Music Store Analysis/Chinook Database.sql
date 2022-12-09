/*******************************************************************************
   Chinook Database - Version 1.4
   Script: Chinook_SqlServer.sql
   Description: Creates and populates the Chinook database.
   DB Server: SqlServer
   Author: Luis Rocha
   License: http://www.codeplex.com/ChinookDatabase/license
********************************************************************************/

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Chinook')
BEGIN
	ALTER DATABASE [Chinook] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [Chinook] SET ONLINE;
	DROP DATABASE [Chinook];
END

GO

/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE [Chinook];
GO

USE [Chinook];
GO

/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE [dbo].[Album]
(
    [AlbumId] INT NOT NULL IDENTITY,
    [Title] NVARCHAR(160) NOT NULL,
    [ArtistId] INT NOT NULL,
    CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED ([AlbumId])
);
GO
CREATE TABLE [dbo].[Artist]
(
    [ArtistId] INT NOT NULL IDENTITY,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED ([ArtistId])
);
GO
CREATE TABLE [dbo].[Customer]
(
    [CustomerId] INT NOT NULL IDENTITY,
    [FirstName] NVARCHAR(40) NOT NULL,
    [LastName] NVARCHAR(20) NOT NULL,
    [Company] NVARCHAR(80),
    [Address] NVARCHAR(70),
    [City] NVARCHAR(40),
    [State] NVARCHAR(40),
    [Country] NVARCHAR(40),
    [PostalCode] NVARCHAR(10),
    [Phone] NVARCHAR(24),
    [Fax] NVARCHAR(24),
    [Email] NVARCHAR(60) NOT NULL,
    [SupportRepId] INT,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId])
);
GO
CREATE TABLE [dbo].[Employee]
(
    [EmployeeId] INT NOT NULL IDENTITY,
    [LastName] NVARCHAR(20) NOT NULL,
    [FirstName] NVARCHAR(20) NOT NULL,
    [Title] NVARCHAR(30),
    [ReportsTo] INT,
    [BirthDate] DATETIME,
    [HireDate] DATETIME,
    [Address] NVARCHAR(70),
    [City] NVARCHAR(40),
    [State] NVARCHAR(40),
    [Country] NVARCHAR(40),
    [PostalCode] NVARCHAR(10),
    [Phone] NVARCHAR(24),
    [Fax] NVARCHAR(24),
    [Email] NVARCHAR(60),
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeId])
);
GO
CREATE TABLE [dbo].[Genre]
(
    [GenreId] INT NOT NULL IDENTITY,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED ([GenreId])
);
GO
CREATE TABLE [dbo].[Invoice]
(
    [InvoiceId] INT NOT NULL IDENTITY,
    [CustomerId] INT NOT NULL,
    [InvoiceDate] DATETIME NOT NULL,
    [BillingAddress] NVARCHAR(70),
    [BillingCity] NVARCHAR(40),
    [BillingState] NVARCHAR(40),
    [BillingCountry] NVARCHAR(40),
    [BillingPostalCode] NVARCHAR(10),
    [Total] NUMERIC(10,2) NOT NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([InvoiceId])
);
GO
CREATE TABLE [dbo].[InvoiceLine]
(
    [InvoiceLineId] INT NOT NULL IDENTITY,
    [InvoiceId] INT NOT NULL,
    [TrackId] INT NOT NULL,
    [UnitPrice] NUMERIC(10,2) NOT NULL,
    [Quantity] INT NOT NULL,
    CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED ([InvoiceLineId])
);
GO
CREATE TABLE [dbo].[MediaType]
(
    [MediaTypeId] INT NOT NULL IDENTITY,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_MediaType] PRIMARY KEY CLUSTERED ([MediaTypeId])
);
GO