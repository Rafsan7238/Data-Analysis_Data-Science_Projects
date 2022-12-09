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
CREATE TABLE [dbo].[Playlist]
(
    [PlaylistId] INT NOT NULL IDENTITY,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Playlist] PRIMARY KEY CLUSTERED ([PlaylistId])
);
GO
CREATE TABLE [dbo].[PlaylistTrack]
(
    [PlaylistId] INT NOT NULL,
    [TrackId] INT NOT NULL,
    CONSTRAINT [PK_PlaylistTrack] PRIMARY KEY NONCLUSTERED ([PlaylistId], [TrackId])
);
GO
CREATE TABLE [dbo].[Track]
(
    [TrackId] INT NOT NULL IDENTITY,
    [Name] NVARCHAR(200) NOT NULL,
    [AlbumId] INT,
    [MediaTypeId] INT NOT NULL,
    [GenreId] INT,
    [Composer] NVARCHAR(220),
    [Milliseconds] INT NOT NULL,
    [Bytes] INT,
    [UnitPrice] NUMERIC(10,2) NOT NULL,
    CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED ([TrackId])
);
GO

/*******************************************************************************
   Create Primary Key Unique Indexes
********************************************************************************/

/*******************************************************************************
   Create Foreign Keys
********************************************************************************/
ALTER TABLE [dbo].[Album] ADD CONSTRAINT [FK_AlbumArtistId]
    FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_AlbumArtistId] ON [dbo].[Album] ([ArtistId]);
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_CustomerSupportRepId]
    FOREIGN KEY ([SupportRepId]) REFERENCES [dbo].[Employee] ([EmployeeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_CustomerSupportRepId] ON [dbo].[Customer] ([SupportRepId]);
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_EmployeeReportsTo]
    FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employee] ([EmployeeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_EmployeeReportsTo] ON [dbo].[Employee] ([ReportsTo]);
GO
ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [FK_InvoiceCustomerId]
    FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_InvoiceCustomerId] ON [dbo].[Invoice] ([CustomerId]);
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineInvoiceId]
    FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_InvoiceLineInvoiceId] ON [dbo].[InvoiceLine] ([InvoiceId]);
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineTrackId]
    FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_InvoiceLineTrackId] ON [dbo].[InvoiceLine] ([TrackId]);
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackPlaylistId]
    FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[Playlist] ([PlaylistId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackTrackId]
    FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_PlaylistTrackTrackId] ON [dbo].[PlaylistTrack] ([TrackId]);
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackAlbumId]
    FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_TrackAlbumId] ON [dbo].[Track] ([AlbumId]);
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackGenreId]
    FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_TrackGenreId] ON [dbo].[Track] ([GenreId]);
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackMediaTypeId]
    FOREIGN KEY ([MediaTypeId]) REFERENCES [dbo].[MediaType] ([MediaTypeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE INDEX [IFK_TrackMediaTypeId] ON [dbo].[Track] ([MediaTypeId]);
GO


/*******************************************************************************
   Populate Tables
********************************************************************************/
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Rock');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Jazz');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Metal');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Alternative & Punk');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Rock And Roll');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Blues');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Latin');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Reggae');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Pop');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Soundtrack');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Bossa Nova');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Easy Listening');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Heavy Metal');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'R&B/Soul');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Electronica/Dance');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'World');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Hip Hop/Rap');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Science Fiction');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'TV Shows');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Sci Fi & Fantasy');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Drama');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Comedy');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Alternative');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Classical');
INSERT INTO [dbo].[Genre] ([Name]) VALUES (N'Opera');

INSERT INTO [dbo].[MediaType] ([Name]) VALUES (N'MPEG audio file');
INSERT INTO [dbo].[MediaType] ([Name]) VALUES (N'Protected AAC audio file');
INSERT INTO [dbo].[MediaType] ([Name]) VALUES (N'Protected MPEG-4 video file');
INSERT INTO [dbo].[MediaType] ([Name]) VALUES (N'Purchased AAC audio file');
INSERT INTO [dbo].[MediaType] ([Name]) VALUES (N'AAC audio file');

INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'AC/DC');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Accept');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aerosmith');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Alanis Morissette');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Alice In Chains');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Antônio Carlos Jobim');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Apocalyptica');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Audioslave');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'BackBeat');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Billy Cobham');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Black Label Society');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Black Sabbath');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Body Count');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Bruce Dickinson');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Buddy Guy');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Caetano Veloso');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chico Buarque');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chico Science & Nação Zumbi');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Cidade Negra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Cláudio Zoli');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Various Artists');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Led Zeppelin');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Frank Zappa & Captain Beefheart');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Marcos Valle');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Milton Nascimento & Bebeto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Azymuth');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gilberto Gil');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'João Gilberto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Bebel Gilberto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jorge Vercilo');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Baby Consuelo');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Ney Matogrosso');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Luiz Melodia');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nando Reis');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Pedro Luís & A Parede');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'O Rappa');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Ed Motta');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Banda Black Rio');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Fernanda Porto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Os Cariocas');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Elis Regina');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Milton Nascimento');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'A Cor Do Som');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Kid Abelha');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Sandra De Sá');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jorge Ben');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Hermeto Pascoal');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Barão Vermelho');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Edson, DJ Marky & DJ Patife Featuring Fernanda Porto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Metallica');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Queen');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Kiss');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Spyro Gyra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Green Day');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'David Coverdale');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gonzaguinha');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Os Mutantes');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Deep Purple');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Dave Matthews');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Everlast');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Rob Thomas');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Lauryn Hill & Cee-Lo');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. The Project G&B');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Maná');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Eagle-Eye Cherry');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Santana Feat. Eric Clapton');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Miles Davis');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gene Krupa');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Toquinho & Vinícius');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Vinícius De Moraes & Baden Powell');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Vinícius De Moraes');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Vinícius E Qurteto Em Cy');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Vinícius E Odette Lara');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Vinicius, Toquinho & Quarteto Em Cy');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Creedence Clearwater Revival');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Cássia Eller');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Def Leppard');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Dennis Chambers');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Djavan');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Eric Clapton');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Faith No More');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Falamansa');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Foo Fighters');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Frank Sinatra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Funk Como Le Gusta');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Godsmack');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Guns N'' Roses');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Incognito');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Iron Maiden');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'James Brown');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jamiroquai');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'JET');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jimi Hendrix');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Joe Satriani');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jota Quest');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'João Suplicy');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Judas Priest');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Legião Urbana');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Lenny Kravitz');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Lulu Santos');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Marillion');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Marisa Monte');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Marvin Gaye');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Men At Work');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Motörhead');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Motörhead & Girlschool');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Mônica Marianno');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Mötley Crüe');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nirvana');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'O Terço');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Olodum');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Os Paralamas Do Sucesso');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Ozzy Osbourne');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Page & Plant');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Passengers');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Paul D''Ianno');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Pearl Jam');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Peter Tosh');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Pink Floyd');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Planet Hemp');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'R.E.M. Feat. Kate Pearson');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'R.E.M. Feat. KRS-One');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'R.E.M.');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Raimundos');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Raul Seixas');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Red Hot Chili Peppers');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Rush');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Simply Red');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Skank');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Smashing Pumpkins');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Soundgarden');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Stevie Ray Vaughan & Double Trouble');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Stone Temple Pilots');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'System Of A Down');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Terry Bozzio, Tony Levin & Steve Stevens');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Black Crowes');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Clash');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Cult');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Doors');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Police');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Rolling Stones');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Tea Party');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Who');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Tim Maia');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Titãs');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Battlestar Galactica');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Heroes');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Lost');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'U2');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'UB40');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Van Halen');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Velvet Revolver');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Whitesnake');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Zeca Pagodinho');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Office');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Dread Zeppelin');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Battlestar Galactica (Classic)');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aquaman');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Christina Aguilera featuring BigElf');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aerosmith & Sierra Leone''s Refugee Allstars');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Los Lonely Boys');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Corinne Bailey Rae');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Dhani Harrison & Jakob Dylan');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jackson Browne');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Avril Lavigne');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Big & Rich');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Youssou N''Dour');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Black Eyed Peas');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jack Johnson');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Ben Harper');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Snow Patrol');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Matisyahu');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Postal Service');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jaguares');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Flaming Lips');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Jack''s Mannequin & Mick Fleetwood');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Regina Spektor');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Scorpions');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'House Of Pain');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Xis');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nega Gizza');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gustavo & Andres Veiga & Salazar');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Rodox');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Charlie Brown Jr.');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Pedro Luís E A Parede');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Los Hermanos');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Mundo Livre S/A');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Otto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Instituto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nação Zumbi');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'DJ Dolores & Orchestra Santa Massa');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Seu Jorge');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Sabotage E Instituto');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Stereo Maracana');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Cake');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aisha Duo');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Habib Koité and Bamada');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Karsh Kale');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The Posies');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Luciana Souza/Romero Lubambo');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aaron Goldberg');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nicolaus Esterhazy Sinfonia');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Temple of the Dog');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chris Cornell');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Alberto Turco & Nova Schola Gregoriana');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Richard Marlow & The Choir of Trinity College, Cambridge');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'English Concert & Trevor Pinnock');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Anne-Sophie Mutter, Herbert Von Karajan & Wiener Philharmoniker');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Hilary Hahn, Jeffrey Kahane, Los Angeles Chamber Orchestra & Margaret Batjer');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Wilhelm Kempff');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Yo-Yo Ma');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Scholars Baroque Ensemble');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Academy of St. Martin in the Fields & Sir Neville Marriner');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Academy of St. Martin in the Fields Chamber Ensemble & Sir Neville Marriner');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Berliner Philharmoniker, Claudio Abbado & Sabine Meyer');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Royal Philharmonic Orchestra & Sir Thomas Beecham');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Orchestre Révolutionnaire et Romantique & John Eliot Gardiner');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Britten Sinfonia, Ivor Bolton & Lesley Garrett');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chicago Symphony Chorus, Chicago Symphony Orchestra & Sir Georg Solti');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Sir Georg Solti & Wiener Philharmoniker');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Academy of St. Martin in the Fields, John Birch, Sir Neville Marriner & Sylvia McNair');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'London Symphony Orchestra & Sir Charles Mackerras');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Barry Wordsworth & BBC Concert Orchestra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Herbert Von Karajan, Mirella Freni & Wiener Philharmoniker');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Eugene Ormandy');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Luciano Pavarotti');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Leonard Bernstein & New York Philharmonic');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Boston Symphony Orchestra & Seiji Ozawa');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Aaron Copland & London Symphony Orchestra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Ton Koopman');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Sergei Prokofiev & Yuri Temirkanov');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chicago Symphony Orchestra & Fritz Reiner');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Orchestra of The Age of Enlightenment');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Emanuel Ax, Eugene Ormandy & Philadelphia Orchestra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'James Levine');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Berliner Philharmoniker & Hans Rosbaud');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Maurizio Pollini');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Academy of St. Martin in the Fields, Sir Neville Marriner & William Bennett');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gustav Mahler');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Felix Schmidt, London Symphony Orchestra & Rafael Frühbeck de Burgos');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Edo de Waart & San Francisco Symphony');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Antal Doráti & London Symphony Orchestra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Choir Of Westminster Abbey & Simon Preston');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Michael Tilson Thomas & San Francisco Symphony');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Chor der Wiener Staatsoper, Herbert Von Karajan & Wiener Philharmoniker');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The King''s Singers');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Berliner Philharmoniker & Herbert Von Karajan');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Sir Georg Solti, Sumi Jo & Wiener Philharmoniker');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Christopher O''Riley');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Fretwork');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Amy Winehouse');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Calexico');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Otto Klemperer & Philharmonia Orchestra');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Yehudi Menuhin');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Philharmonia Orchestra & Sir Neville Marriner');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Academy of St. Martin in the Fields, Sir Neville Marriner & Thurston Dart');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Les Arts Florissants & William Christie');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'The 12 Cellists of The Berlin Philharmonic');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Adrian Leaper & Doreen de Feis');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Roger Norrington, London Classical Players');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Charles Dutoit & L''Orchestre Symphonique de Montréal');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Equale Brass Ensemble, John Eliot Gardiner & Munich Monteverdi Orchestra and Choir');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Kent Nagano and Orchestre de l''Opéra de Lyon');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Julian Bream');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Martin Roscoe');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Göteborgs Symfoniker & Neeme Järvi');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Itzhak Perlman');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Michele Campanella');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Gerald Moore');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Mela Tenenbaum, Pro Musica Prague & Richard Kapp');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Emerson String Quartet');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'C. Monteverdi, Nigel Rogers - Chiaroscuro; London Baroque; London Cornett & Sackbu');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Nash Ensemble');
INSERT INTO [dbo].[Artist] ([Name]) VALUES (N'Philip Glass Ensemble');