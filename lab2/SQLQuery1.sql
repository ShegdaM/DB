IF EXISTS(SELECT * FROM sys.databases where name = 'Project')
DROP DATABASE Project;

CREATE DATABASE Project;

use Project;

CREATE TABLE Movie(
	idMovie INT NOT NULL IDENTITY(1,1),
	MovieName VARCHAR(99),
	MovieDuration TIME,
	Country VARCHAR(99),
	Genre VARCHAR(99),
	Rating INT,
  PRIMARY KEY (idMovie)
);

CREATE TABLE Hall(
	id INT NOT NULL IDENTITY(1,1),
	Halltype VARCHAR(10),
	Places INT,
	HallNumber INT,
	PRIMARY KEY (id)
);

CREATE TABLE Schedule(
	id INT NOT NULL IDENTITY(1,1),
	MovieName VARCHAR(99),
	DateMovie DATE,
	MovieDuration TIME,
	PRIMARY KEY (id),
	CONSTRAINT FK_Schedule_Movie FOREIGN KEY (id)
    REFERENCES Movie (idMovie) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Schedule_Hall FOREIGN KEY (id)
    REFERENCES Hall (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Client(
	id INT NOT NULL IDENTITY(1,1),
	ClientName VARCHAR(99),
	Bonus TINYINT,
	PhoneNumbre INT
	PRIMARY KEY(id)
);

CREATE TABLE Ticket(
	MoviePrice INT NOT NULL,
    ClientID VARCHAR(99) NOT NULL,
    DatePay VARCHAR(99) NULL,
    TicketStatus VARCHAR(99) NOT NULL,
    Place INT NOT NULL,
    RowPlace INT NOT NULL,
    TicketID INT NOT NULL IDENTITY(1,1),
    PRIMARY KEY (TicketID, MoviePrice),
    CONSTRAINT FK_Ticket_Schedule FOREIGN KEY (MoviePrice)
    REFERENCES Schedule (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Ticket_Client FOREIGN KEY (MoviePrice)
    REFERENCES Client (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Cities(
	id INT NOT NULL IDENTITY(1,1),
	City VARCHAR(99),
	PRIMARY KEY (id)
);

CREATE TABLE Streets(
	id INT NOT NULL IDENTITY(1,1),
	StreetName VARCHAR(99),
	CitiesId INT NOT NULL,
	PRIMARY KEY (CitiesId),
	CONSTRAINT FK_Streets_Cities FOREIGN KEY (CitiesId)
	REFERENCES Cities (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Cinema(
	id INT NOT NULL IDENTITY(1,1),
	WorkTime TIME,
	StreetsId INT,
	CONSTRAINT FK_Cinema_Hall FOREIGN KEY (id)
	REFERENCES Hall (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT FK_Cinema_Streets FOREIGN KEY (StreetsId)
	REFERENCES Streets (CitiesId) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Genres(
	id INT NOT NULL IDENTITY(1,1),
	GenreName VARCHAR(99),
	PRIMARY KEY (id)
);

CREATE TABLE Movie_has_Genres(
	MovieId INT NOT NUll,
	GenreId INT NOT NULL,
	PRIMARY KEY (MovieId, GenreId),
	CONSTRAINT FK_Movie_has_Genres_Movie FOREIGN KEY (MovieId)
	REFERENCES Movie (idMovie) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT FK_Movie_has_Genres_Genres FOREIGN KEY (GenreId)
	REFERENCES Genres (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);