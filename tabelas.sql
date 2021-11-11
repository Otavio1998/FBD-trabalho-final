--CREATE TABLE Estudantes
--(email VARCHAR(50) NOT NULL,
--nomeUser VARCHAR(50) NOT NULL,
--PRIMARY KEY(email));

--CREATE TABLE Moderadores
--(emailMod VARCHAR(50) NOT NULL,
--nomeMod VARCHAR(50) NOT NULL,
--FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum),
--PRIMARY KEY(emailMod));

DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario
(email VARCHAR(50) NOT NULL,
nomeUser VARCHAR(50) NOT NULL,
qtXp INTEGER,
--FOREIGN KEY (qualForum) REFERENCES Forum(idiomaForum),
--FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard),
--FOREIGN KEY (moderadorQueBaniuEle) REFERENCES Usuario(email);
--FOREIGN KEY (elo) REFERENCES Liga(elo);
PRIMARY KEY(email));


DROP TABLE IF EXISTS Achievements;
CREATE TABLE Achievements
(nome VARCHAR(100) NOT NULL,
requisito VARCHAR(200) NOT NULL,
PRIMARY KEY(nome));


DROP TABLE IF EXISTS Idioma;
CREATE TABLE Idioma
(nomeIdi VARCHAR(50) NOT NULL,
PRIMARY KEY(nomeIdi));


DROP TABLE IF EXISTS Cursos;
CREATE TABLE Cursos
(nomeIdiomaOrigem VARCHAR(50) NOT NULL,
nomeIdiomaDestino VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdiomaOrigem) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
FOREIGN KEY (nomeIdiomaDestino) REFERENCES Idioma(nomeIdi),
		ON UPDATE CASCADE
		ON DELETE CASCADE,
PRIMARY KEY(nomeIdiomaOrigem,nomeIdiomaDestino));


DROP TABLE IF EXISTS Item;
CREATE TABLE Item
(nomeItem VARCHAR(50) NOT NULL,
preco INTEGER NOT NULL,
PRIMARY KEY(nomeItem));


DROP TABLE IF EXISTS Licoes;
CREATE TABLE Licoes
(assunto VARCHAR(50) NOT NULL,
fases INTEGER  NOT NULL,
nomeIdiomaOrigem VARCHAR(50) NOT NULL,
nomeIdiomaDestino VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdiomaOrigem,nomeIdiomaDestino) REFERENCES Cursos(nomeIdiomaOrigem,nomeIdiomaDestino),
PRIMARY KEY(assunto));


DROP TABLE IF EXISTS Palavras;
CREATE TABLE Palavras
(nomePal VARCHAR(25) NOT NULL,
niveldedominio INTEGER NOT NULL,
ultimavezvista   DATE NOT NULL,
nomeIdi VARCHAR(50) NOT NULL,
FOREIGN KEY (nomeIdi) REFERENCES Idioma(nomeIdi),
PRIMARY KEY(nomePal));


DROP TABLE IF EXISTS Forum;
CREATE TABLE Forum
(idiomaForum VARCHAR(30) NOT NULL,
PRIMARY KEY(idiomaForum));


DROP TABLE IF EXISTS Threads;
CREATE TABLE Threads
(titulo VARCHAR(100) NOT NULL,
email VARCHAR(50) NOT NULL,
idiomaForum VARCHAR(30) NOT NULL,
FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum),
FOREIGN KEY (email) REFERENCES Usuario(email),
PRIMARY KEY(titulo));


DROP TABLE IF EXISTS Leaderboard;
CREATE TABLE Leaderboard
(idLeaderboard VARCHAR(30) NOT NULL,
elo VARCHAR(30) NOT NULL,
FOREIGN KEY (elo) REFERENCES Liga(elo)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
PRIMARY KEY(idLeaderboard));


DROP TABLE IF EXISTS Liga;
CREATE TABLE Liga
(elo VARCHAR(30) NOT NULL,
idLeaderboard VARCHAR(30) NOT NULL,
FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
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
FOREIGN KEY (email) REFERENCES Usuario(email)); -- Acho que aqui está errado o uso de estudantes, mas não sei como fazer os usários daí

