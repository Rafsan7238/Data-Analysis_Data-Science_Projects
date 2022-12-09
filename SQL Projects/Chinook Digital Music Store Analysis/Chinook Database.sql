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

INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'For Those About To Rock We Salute You', 1);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Balls to the Wall', 2);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Restless and Wild', 2);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Let There Be Rock', 1);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Big Ones', 3);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Jagged Little Pill', 4);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Facelift', 5);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Warner 25 Anos', 6);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Plays Metallica By Four Cellos', 7);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Audioslave', 8);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Out Of Exile', 8);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'BackBeat Soundtrack', 9);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of Billy Cobham', 10);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Alcohol Fueled Brewtality Live! [Disc 1]', 11);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Alcohol Fueled Brewtality Live! [Disc 2]', 11);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Black Sabbath', 12);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Black Sabbath Vol. 4 (Remaster)', 12);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Body Count', 13);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chemical Wedding', 14);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of Buddy Guy - The Millenium Collection', 15);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Prenda Minha', 16);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Sozinho Remix Ao Vivo', 16);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Minha Historia', 17);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Afrociberdelia', 18);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Da Lama Ao Caos', 18);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Acústico MTV [Live]', 19);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cidade Negra - Hits', 19);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Na Pista', 20);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Axé Bahia 2001', 21);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'BBC Sessions [Disc 1] [Live]', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bongo Fury', 23);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Carnaval 2001', 21);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chill: Brazil (Disc 1)', 24);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chill: Brazil (Disc 2)', 6);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Garage Inc. (Disc 1)', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Greatest Hits II', 51);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Greatest Kiss', 52);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Heart of the Night', 53);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'International Superhits', 54);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Into The Light', 55);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Meus Momentos', 56);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Minha História', 57);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'MK III The Final Concerts [Disc 1]', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Physical Graffiti [Disc 1]', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Sambas De Enredo 2001', 21);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Supernatural', 59);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best of Ed Motta', 37);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Essential Miles Davis [Disc 1]', 68);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Essential Miles Davis [Disc 2]', 68);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Final Concerts (Disc 2)', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Up An'' Atom', 69);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vinícius De Moraes - Sem Limite', 70);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vozes do MPB', 21);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chronicle, Vol. 1', 76);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chronicle, Vol. 2', 76);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cássia Eller - Coleção Sem Limite [Disc 2]', 77);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cássia Eller - Sem Limite [Disc 1]', 77);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Come Taste The Band', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Deep Purple In Rock', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Fireball', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Knocking at Your Back Door: The Best Of Deep Purple in the 80''s', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Machine Head', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Purpendicular', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Slaves And Masters', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Stormbringer', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Battle Rages On', 58);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vault: Def Leppard''s Greatest Hits', 78);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Outbreak', 79);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Djavan Ao Vivo - Vol. 02', 80);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Djavan Ao Vivo - Vol. 1', 80);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Elis Regina-Minha História', 41);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Cream Of Clapton', 81);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Unplugged', 81);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Album Of The Year', 82);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Angel Dust', 82);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'King For A Day Fool For A Lifetime', 82);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Real Thing', 82);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Deixa Entrar', 83);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'In Your Honor [Disc 1]', 84);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'In Your Honor [Disc 2]', 84);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'One By One', 84);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Colour And The Shape', 84);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'My Way: The Best Of Frank Sinatra [Disc 1]', 85);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Roda De Funk', 86);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'As Canções de Eu Tu Eles', 27);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Quanta Gente Veio Ver (Live)', 27);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Quanta Gente Veio ver--Bônus De Carnaval', 27);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Faceless', 87);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'American Idiot', 54);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Appetite for Destruction', 88);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Use Your Illusion I', 88);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Use Your Illusion II', 88);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Blue Moods', 89);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A Matter of Life and Death', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A Real Dead One', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A Real Live One', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Brave New World', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Dance Of Death', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Fear Of The Dark', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Iron Maiden', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Killers', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live After Death', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live At Donington 1992 (Disc 1)', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live At Donington 1992 (Disc 2)', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'No Prayer For The Dying', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Piece Of Mind', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Powerslave', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Rock In Rio [CD1]', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Rock In Rio [CD2]', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Seventh Son of a Seventh Son', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Somewhere in Time', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Number of The Beast', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The X Factor', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Virtual XI', 90);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Sex Machine', 91);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Emergency On Planet Earth', 92);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Synkronized', 92);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Return Of The Space Cowboy', 92);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Get Born', 93);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Are You Experienced?', 94);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Surfing with the Alien (Remastered)', 95);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Jorge Ben Jor 25 Anos', 46);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Jota Quest-1995', 96);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cafezinho', 97);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Living After Midnight', 98);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Unplugged [Live]', 52);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'BBC Sessions [Disc 2] [Live]', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Coda', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Houses Of The Holy', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'In Through The Out Door', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'IV', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Led Zeppelin I', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Led Zeppelin II', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Led Zeppelin III', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Physical Graffiti [Disc 2]', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Presence', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Song Remains The Same (Disc 1)', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Song Remains The Same (Disc 2)', 22);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A TempestadeTempestade Ou O Livro Dos Dias', 99);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mais Do Mesmo', 99);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Greatest Hits', 100);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Lulu Santos - RCA 100 Anos De Música - Álbum 01', 101);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Lulu Santos - RCA 100 Anos De Música - Álbum 02', 101);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Misplaced Childhood', 102);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Barulhinho Bom', 103);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Seek And Shall Find: More Of The Best (1963-1981)', 104);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of Men At Work', 105);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Black Album', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Garage Inc. (Disc 2)', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Kill ''Em All', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Load', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Master Of Puppets', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'ReLoad', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Ride The Lightning', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'St. Anger', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'...And Justice For All', 50);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Miles Ahead', 68);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Milton Nascimento Ao Vivo', 42);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Minas', 42);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Ace Of Spades', 106);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Demorou...', 108);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Motley Crue Greatest Hits', 109);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'From The Muddy Banks Of The Wishkah [Live]', 110);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Nevermind', 110);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Compositores', 111);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Olodum', 112);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Acústico MTV', 113);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Arquivo II', 113);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Arquivo Os Paralamas Do Sucesso', 113);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bark at the Moon (Remastered)', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Blizzard of Ozz', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Diary of a Madman (Remastered)', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'No More Tears (Remastered)', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Tribute', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Walking Into Clarksdale', 115);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Original Soundtracks 1', 116);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Beast Live', 117);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live On Two Legs [Live]', 118);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Pearl Jam', 118);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Riot Act', 118);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Ten', 118);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vs.', 118);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Dark Side Of The Moon', 120);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Os Cães Ladram Mas A Caravana Não Pára', 121);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Greatest Hits I', 51);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'News Of The World', 51);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Out Of Time', 122);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Green', 124);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'New Adventures In Hi-Fi', 124);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of R.E.M.: The IRS Years', 124);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cesta Básica', 125);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Raul Seixas', 126);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Blood Sugar Sex Magik', 127);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'By The Way', 127);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Californication', 127);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Retrospective I (1974-1980)', 128);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Santana - As Years Go By', 59);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Santana Live', 59);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Maquinarama', 130);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'O Samba Poconé', 130);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Judas 0: B-Sides and Rarities', 131);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Rotten Apples: Greatest Hits', 131);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A-Sides', 132);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Morning Dance', 53);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'In Step', 133);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Core', 134);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mezmerize', 135);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'[1997] Black Light Syndrome', 136);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live [Disc 1]', 137);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Live [Disc 2]', 137);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Singles', 138);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Beyond Good And Evil', 139);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Pure Cult: The Best Of The Cult (For Rockers, Ravers, Lovers & Sinners) [UK]', 139);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Doors', 140);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Police Greatest Hits', 141);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Hot Rocks, 1964-1971 (Disc 1)', 142);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'No Security', 142);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Voodoo Lounge', 142);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Tangents', 143);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Transmission', 143);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'My Generation - The Very Best Of The Who', 144);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Serie Sem Limite (Disc 1)', 145);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Serie Sem Limite (Disc 2)', 145);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Acústico', 146);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Volume Dois', 146);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Battlestar Galactica: The Story So Far', 147);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Battlestar Galactica, Season 3', 147);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Heroes, Season 1', 148);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Lost, Season 3', 149);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Lost, Season 1', 149);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Lost, Season 2', 149);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Achtung Baby', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'All That You Can''t Leave Behind', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'B-Sides 1980-1990', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'How To Dismantle An Atomic Bomb', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Pop', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Rattle And Hum', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of 1980-1990', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'War', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Zooropa', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'UB40 The Best Of - Volume Two [UK]', 151);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Diver Down', 152);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best Of Van Halen, Vol. I', 152);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Van Halen', 152);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Van Halen III', 152);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Contraband', 153);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vinicius De Moraes', 72);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Ao Vivo [IMPORT]', 155);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Office, Season 1', 156);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Office, Season 2', 156);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Office, Season 3', 156);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Un-Led-Ed', 157);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Battlestar Galactica (Classic), Season 1', 158);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Aquaman', 159);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Instant Karma: The Amnesty International Campaign to Save Darfur', 150);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Speak of the Devil', 114);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'20th Century Masters - The Millennium Collection: The Best of Scorpions', 179);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'House of Pain', 180);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Radio Brasil (O Som da Jovem Vanguarda) - Seleccao de Henrique Amaro', 36);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Cake: B-Sides and Rarities', 196);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'LOST, Season 4', 149);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Quiet Songs', 197);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Muso Ko', 198);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Realize', 199);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Every Kind of Light', 200);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Duos II', 201);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Worlds', 202);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Best of Beethoven', 203);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Temple of the Dog', 204);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Carry On', 205);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Revelations', 8);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Adorate Deum: Gregorian Chant from the Proper of the Mass', 206);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Allegri: Miserere', 207);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Pachelbel: Canon & Gigue', 208);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Vivaldi: The Four Seasons', 209);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: Violin Concertos', 210);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: Goldberg Variations', 211);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: The Cello Suites', 212);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Handel: The Messiah (Highlights)', 213);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The World of Classical Favourites', 214);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Sir Neville Marriner: A Celebration', 215);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mozart: Wind Concertos', 216);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Haydn: Symphonies 99 - 104', 217);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Beethoven: Symhonies Nos. 5 & 6', 218);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A Soprano Inspired', 219);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Great Opera Choruses', 220);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Wagner: Favourite Overtures', 221);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Fauré: Requiem, Ravel: Pavane & Others', 222);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Tchaikovsky: The Nutcracker', 223);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Last Night of the Proms', 224);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Puccini: Madama Butterfly - Highlights', 225);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Holst: The Planets, Op. 32 & Vaughan Williams: Fantasies', 226);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Pavarotti''s Opera Made Easy', 227);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Great Performances - Barber''s Adagio and Other Romantic Favorites for Strings', 228);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Carmina Burana', 229);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'A Copland Celebration, Vol. I', 230);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: Toccata & Fugue in D Minor', 231);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Prokofiev: Symphony No.1', 232);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Scheherazade', 233);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: The Brandenburg Concertos', 234);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Chopin: Piano Concertos Nos. 1 & 2', 235);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mascagni: Cavalleria Rusticana', 236);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Sibelius: Finlandia', 237);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Beethoven Piano Sonatas: Moonlight & Pastorale', 238);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Great Recordings of the Century - Mahler: Das Lied von der Erde', 240);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Elgar: Cello Concerto & Vaughan Williams: Fantasias', 241);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Adams, John: The Chairman Dances', 242);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Tchaikovsky: 1812 Festival Overture, Op.49, Capriccio Italien & Beethoven: Wellington''s Victory', 243);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Palestrina: Missa Papae Marcelli & Allegri: Miserere', 244);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Prokofiev: Romeo & Juliet', 245);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Strauss: Waltzes', 226);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Berlioz: Symphonie Fantastique', 245);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bizet: Carmen Highlights', 246);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'English Renaissance', 247);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Handel: Music for the Royal Fireworks (Original Version 1749)', 208);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Grieg: Peer Gynt Suites & Sibelius: Pelléas et Mélisande', 248);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mozart Gala: Famous Arias', 249);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'SCRIABIN: Vers la flamme', 250);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Armada: Music from the Courts of England and Spain', 251);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mozart: Symphonies Nos. 40 & 41', 248);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Back to Black', 252);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Frank', 252);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Carried to Dust (Bonus Track Version)', 253);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Beethoven: Symphony No. 6 ''Pastoral'' Etc.', 254);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bartok: Violin & Viola Concertos', 255);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mendelssohn: A Midsummer Night''s Dream', 256);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Bach: Orchestral Suites Nos. 1 - 4', 257);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Charpentier: Divertissements, Airs & Concerts', 258);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'South American Getaway', 259);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Górecki: Symphony No. 3', 260);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Purcell: The Fairy Queen', 261);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'The Ultimate Relexation Album', 262);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Purcell: Music for the Queen Mary', 263);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Weill: The Seven Deadly Sins', 264);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'J.S. Bach: Chaconne, Suite in E Minor, Partita in E Major & Prelude, Fugue and Allegro', 265);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Prokofiev: Symphony No.5 & Stravinksy: Le Sacre Du Printemps', 248);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Szymanowski: Piano Works, Vol. 1', 266);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Nielsen: The Six Symphonies', 267);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Great Recordings of the Century: Paganini''s 24 Caprices', 268);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Liszt - 12 Études D''Execution Transcendante', 269);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Great Recordings of the Century - Shubert: Schwanengesang, 4 Lieder', 270);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Locatelli: Concertos for Violin, Strings and Continuo, Vol. 3', 271);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Respighi:Pines of Rome', 226);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Schubert: The Late String Quartets & String Quintet (3 CD''s)', 272);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Monteverdi: L''Orfeo', 273);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Mozart: Chamber Music', 274);
INSERT INTO [dbo].[Album] ([Title], [ArtistId]) VALUES (N'Koyaanisqatsi (Soundtrack from the Motion Picture)', 275);