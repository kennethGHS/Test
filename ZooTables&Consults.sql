CREATE TABLE Especie
(
    IdEspecie        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre           TEXT,
    NombreCientifico TEXT,
    Descripcion      TEXT,
    IdZona           INTEGER,
    FOREIGN KEY (IdZona) REFERENCES Zona (IdZona)
);

CREATE TABLE Zona
(
    IdZona    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre    TEXT,
    Extension INTEGER
);

CREATE TABLE Habitat
(
    IdHabitat  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre     TEXT,
    Clima      TEXT,
    Vegetacion TEXT
);

CREATE TABLE Continente
(
    IdContinente INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre       TEXT
);

CREATE TABLE HabitatContinente
(
    IdHabitat    INTEGER NOT NULL,
    IdContinente INTEGER NOT NULL,
    FOREIGN KEY (IdHabitat) REFERENCES Habitat (IdHabitat),
    FOREIGN KEY (IdContinente) REFERENCES Continente (IdContinente)
);

CREATE TABLE Itinerario
(
    IdItinerario     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo           TEXT,
    Duracion         INTEGER,
    Longitud         INTEGER,
    MaxVisitantes    INTEGER,
    CantidadEspecies INTEGER
);

CREATE TABLE Empleado
(
    IdEmpleado  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre      TEXT,
    Direccion   TEXT,
    Telefono    TEXT,
    FechaInicio DATE,
    Salario INTEGER
);

CREATE TABLE Guia
(
    IdGuia     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdEmpleado INTEGER,
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

CREATE TABLE GuiaItinerario
(
    IdGuia       INTEGER NOT NULL,
    IdItinerario INTEGER NOT NULL,
    Fecha        DATE    NOT NULL,
    Hora         TEXT,
    FOREIGN KEY (IdGuia) REFERENCES Guia (IdGuia),
    FOREIGN KEY (IdItinerario) REFERENCES Itinerario (IdItinerario)
);

CREATE TABLE Cuidador
(
    IdCuidador INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdEmpleado INTEGER,
    FechaInicio DATE,
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

CREATE TABLE CuidadorEspecie
(
    IdCuidador INTEGER NOT NULL,
    IdEspecie  INTEGER NOT NULL,
    FOREIGN KEY (IdCuidador) REFERENCES Cuidador (IdCuidador),
    FOREIGN KEY (IdEspecie) REFERENCES Especie (IdEspecie)
);

CREATE TABLE EspecieHabitat
(
    IdEspecie INTEGER NOT NULL,
    IdHabitat INTEGER NOT NULL,
    FOREIGN KEY (IdEspecie) REFERENCES Especie (IdEspecie),
    FOREIGN KEY (IdHabitat) REFERENCES Habitat (IdHabitat)
);

CREATE TABLE ZonaItinerario(
    IdItinerario INTEGER NOT NULL,
    IdZona INTEGER NOT NULL,
    FOREIGN KEY (IdItinerario) REFERENCES Itinerario(IdItinerario),
    FOREIGN KEY (IdZona) REFERENCES Zona(IdZona)
);

INSERT INTO Especie (IdEspecie, Nombre, NombreCientifico, Descripcion, IdZona) VALUES
(1, 'Leon', 'leonus maximus', 'es un gato grande', 1),
(2, 'Ballena', 'ballenatus maximus', 'es una ballena gigante', 1),
(3, 'Oso', 'osus maximus', 'feroz, cafe oso', 2);

INSERT INTO Zona(Nombre, Extension) VALUES
('Jaula', 9),
('Piscina', 25),
('Bosque', 50),
('Sabana', 100);

INSERT INTO Habitat(IdHabitat, Nombre, Clima, Vegetacion) VALUES
(1, 'Marina', 'Mojado', 'Algas'),
(2, 'Sabana', 'Seco', 'Arboles seco'),
(3, 'Bosque', 'Nevado', 'Taiga');

INSERT INTO Empleado(Nombre, Direccion, Telefono, FechaInicio, Salario) VALUES
('Marco', 'Poas', '62093048', '17/09/2013', 120000),
('Kenneth', 'Perez Zeledon', '13245234', '11/09/2011', 50000),
('Jasson', 'Cartago', '62093048', '12/09/2016', 80000),
('Isabel', 'San Carlos', '86304893', '10/08/2015', 300000),
('Carlos', 'San Carlos', '62093048', '1/01/2014', 150000);

INSERT INTO Itinerario(Codigo, Duracion, Longitud, MaxVisitantes, CantidadEspecies) VALUES
('A12', 2, 4, 10, 4),
('A12', 3, 1, 20, 2),
('A12', 4, 2, 10, 3),
('A12', 1, 6, 15, 2);

INSERT INTO Continente(Nombre) VALUES
('Africa'),
('America'),
('Europa'),
('Asia'),
('Antartida'),
('Oceania');

INSERT INTO ZonaItinerario(IdItinerario, IdZona) VALUES
(1, 2),
(2, 3),
(4, 1),
(3, 4);

INSERT INTO EspecieHabitat(IdEspecie, IdHabitat) VALUES
(1, 2),
(2, 1),
(3, 3);

INSERT INTO Guia(IdEmpleado)
VALUES (1),
       (2),
       (3);


INSERT INTO Cuidador(IdEmpleado, FechaInicio)
VALUES (4, '2015-10-08'),
       (5, '2006-10-08'),
       (1, '2013-10-08');

INSERT INTO GuiaItinerario(IDGUIA, IDITINERARIO, FECHA, HORA)
VALUES (1, 3, 12, '2013-04-04'),
       (2, 1, 6, '2013-04-04'),
       (3, 2, 3, '2013-04-04');

INSERT INTO HabitatContinente(IdHabitat, IdContinente)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (2, 5),
       (2, 6),
       (3, 2);

INSERT INTO CuidadorEspecie(IdCuidador, IdEspecie) VALUES
(2, 1),
(1, 2),
(3, 3);
SELECT *
FROM Empleado;
SELECT *
FROM Especie
         INNER JOIN CuidadorEspecie CE on Especie.IdEspecie = CE.IdEspecie;

SELECT G.Nombre AS guias ,C.Nombre AS cuidadores
FROM (SELECT E.Nombre
      FROM Guia
               INNER JOIN Empleado E on Guia.IdEmpleado = E.IdEmpleado
      ORDER BY (E.Salario) DESC) AS G,
     (SELECT E.Nombre
      FROM Cuidador
               INNER JOIN Empleado E on Cuidador.IdEmpleado = E.IdEmpleado
      ORDER BY (E.Salario) DESC) AS C;
SELECT *
FROM Cuidador
         INNER JOIN Empleado E on Cuidador.IdEmpleado = E.IdEmpleado
WHERE Cuidador.FechaInicio >= '2015-01-01'
  AND Cuidador.FechaInicio <= '2017-01-01';
SELECT *
FROM Empleado E
WHERE E.Salario < 100000;
SELECT C.Nombre
FROM (SELECT H.*, COUNT(H.IdHabitat) as F
      FROM Habitat H
               INNER JOIN HabitatContinente HC on H.IdHabitat = HC.IdHabitat
      ORDER BY F
      LIMIT 1) C;
SELECT *
FROM (SELECT Z.*, COUNT(E.IdZona) F
      FROM Especie E
               INNER JOIN Zona Z on E.IdZona = Z.IdZona
      GROUP BY Z.IdZona
      ORDER BY F DESC
      LIMIT 5) E
ORDER BY E.Extension;

SELECT *
FROM (SELECT *
      FROM (SELECT *
            FROM (SELECT I2.*
                  FROM (SELECT COSA.* FROM GuiaItinerario COSA WHERE COSA.Fecha = '2013-04-04') GI
                           INNER JOIN Itinerario I2 on GI.IdItinerario = I2.IdItinerario) I--cONSIGO ITINERARIO Y GUIA
                     INNER JOIN ZonaItinerario ZI on I.IdItinerario = ZI.IdItinerario --CONSIGO ZONAS
            ) ZI inner join Zona Z ON ZI.IdZona = Z.IdZona ) cosa