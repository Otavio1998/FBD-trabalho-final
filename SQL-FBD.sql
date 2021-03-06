--CREATE TABLE Estudantes
--(email VARCHAR(50) NOT NULL,
--nomeUser VARCHAR(50) NOT NULL,
--PRIMARY KEY(email));

--CREATE TABLE Moderadores
--(emailMod VARCHAR(50) NOT NULL,
--nomeMod VARCHAR(50) NOT NULL,
--FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum),
--PRIMARY KEY(emailMod));

CREATE TABLE Usuario
(email VARCHAR(50) NOT NULL,
nomeUser VARCHAR(50) NOT NULL,
--FOREIGN KEY (qualForum) REFERENCES Forum(idiomaForum),
--FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard),
--FOREIGN KEY (moderadorQueBaniuEle) REFERENCES Usuario(email);
--FOREIGN KEY (elo) REFERENCES Liga(elo);
PRIMARY KEY(email));

CREATE TABLE Achievements
(nome VARCHAR(100) NOT NULL,
requisito VARCHAR(200) NOT NULL,
PRIMARY KEY(nome));

CREATE TABLE Idioma
(nomeIdi VARCHAR(50) NOT NULL,
PRIMARY KEY(nomeIdi));

CREATE TABLE Cursos
(nomeIdiomaOrigem VARCHAR(50) NOT NULL,
nomeIdiomaDestino VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdiomaOrigem) REFERENCES Idioma(nomeIdi),
FOREIGN KEY (nomeIdiomaDestino) REFERENCES Idioma(nomeIdi),
PRIMARY KEY(nomeIdiomaOrigem,nomeIdiomaDestino));

CREATE TABLE Item
(nomeItem VARCHAR(50) NOT NULL,
preco INTEGER NOT NULL,
PRIMARY KEY(nomeItem));

CREATE TABLE Licoes
(assunto VARCHAR(50) NOT NULL,
fases INTEGER  NOT NULL,
nomeIdiomaOrigem VARCHAR(50) NOT NULL,
nomeIdiomaDestino VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdiomaOrigem,nomeIdiomaDestino) REFERENCES Cursos(nomeIdiomaOrigem,nomeIdiomaDestino),
PRIMARY KEY(assunto));

CREATE TABLE Palavras
(nomePal VARCHAR(25) NOT NULL,
niveldedominio INTEGER NOT NULL,
ultimavezvista   DATE NOT NULL,
nomeIdi VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdi) REFERENCES Idioma(nomeIdi),
PRIMARY KEY(nomePal));

CREATE TABLE Forum
(idiomaForum VARCHAR(30) NOT NULL,
PRIMARY KEY(idiomaForum));

CREATE TABLE Threads
(titulo VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
idiomaForum VARCHAR(30) NOT NULL,
FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum),
FOREIGN KEY (email) REFERENCES Usuario(email),
PRIMARY KEY(titulo));

CREATE TABLE Leaderboard
(idLeaderboard VARCHAR(30) NOT NULL,
elo VARCHAR(30) NOT NULL,
FOREIGN KEY (elo) REFERENCES Liga(elo),
PRIMARY KEY(idLeaderboard));

CREATE TABLE Liga
(elo VARCHAR(30) NOT NULL,
idLeaderboard VARCHAR(30) NOT NULL,
FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard),
PRIMARY KEY(elo));

CREATE TABLE Conquista
(nome VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY (nome,email),
FOREIGN KEY (nome) REFERENCES Conquista(nome),
FOREIGN KEY (email) REFERENCES Usuario(email));

CREATE TABLE Compra
(nomeItem VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
quantidade INTEGER NOT NULL,
PRIMARY KEY (nomeItem,email),
FOREIGN KEY (nomeItem) REFERENCES Compra(nomeItem),
FOREIGN KEY (email) REFERENCES Usuario(email));

CREATE TABLE Inscrito
(idiomaCurso VARCHAR(30) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY (idiomaCurso,email),
FOREIGN KEY (idiomaCurso) REFERENCES Cursos(idiomaCurso),
FOREIGN KEY (email) REFERENCES Usuario(email));

CREATE TABLE Resposta
(titulo VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY (titulo,email),
FOREIGN KEY (titulo) REFERENCES Threads(titulo),
FOREIGN KEY (email) REFERENCES Usuario(email)); -- Acho que aqui est?? errado o uso de estudantes, mas n??o sei como fazer os us??rios da??


--INSERT INTO Estudantes VALUES ('joseph_joestar@jojo.com','JoJoseph', '{"Japon??s","Ingl??s"}');
--INSERT INTO Estudantes VALUES ('Daenerys@targaryen.com','MotherOfDragons', '{"Dothraki","Ingl??s"}');
--INSERT INTO Estudantes VALUES ('Brynden@rivers.com','Bloodraven', '{"Alto Valiriano","Ingl??s"}');

--INSERT INTO Moderadores VALUES ('jotaro_kujo@jojo.com','JoJotaro');
--INSERT INTO Moderadores VALUES ('aang@avatar.com','DLastAirbender');
--INSERT INTO Moderadores VALUES ('korra@avatar.com','AvatarKorra');

--INSERT INTO Achievements VALUES ('Mago','Ganhe 5000XP');
--INSERT INTO Achievements VALUES ('Estudioso','Aprenda 50 novas palavras em um s?? curso');
--INSERT INTO Achievements VALUES ('Poliglota','Aprenda 50 novas palavras em mais de 3 cursos');


INSERT INTO Threads VALUES ('Melhores apps para aprender Japon??s', 'EstudanteDeJapones123');
INSERT INTO Threads VALUES ('Qual o idioma mais dif??cil de aprender?', 'Estudante123');

INSERT INTO Linguas VALUES ('Japon??s');
INSERT INTO Linguas VALUES ('Ingl??s');
INSERT INTO Linguas VALUES ('Italiano');

INSERT INTO Item VALUES ('Dobro ou Nada', 5);
INSERT INTO Item VALUES ('Streak Freeze', 10);

INSERT INTO Licoes VALUES ('Animais', 1);
INSERT INTO Licoes VALUES ('Comida', 2);
INSERT INTO Licoes VALUES ('Fam??lia', 3);

INSERT INTO Cursos VALUES ('Italiano');
INSERT INTO Cursos VALUES ('Japon??s');
INSERT INTO Cursos VALUES ('Espanhol');

INSERT INTO Palavras VALUES('Batata',10,'2012-12-12');
INSERT INTO Palavras VALUES('Hamburguer',6,'2012-12-12');
INSERT INTO Palavras VALUES('Refrigerante',7,'2012-12-12');

INSERT INTO Forum VALUES ('Italiano');
INSERT INTO Forum VALUES ('Ingl??s');
INSERT INTO Forum VALUES ('Japon??s');


SELECT * FROM Palavras WHERE niveldedominio = 10;
