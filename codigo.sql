DROP TABLE IF EXISTS Idioma;
CREATE TABLE Idioma
(
	nomeIdi VARCHAR(50) NOT NULL,
	PRIMARY KEY(nomeIdi)
);

DROP TABLE IF EXISTS Forum;
CREATE TABLE Forum
PRIMARY KEY(idiomaForum));
(
	id VARCHAR(30) NOT NULL,
	idiomaForum VARCHAR(30) NOT NULL,
	FOREIGN KEY (idiomaForum) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Leaderboard;
CREATE TABLE Leaderboard
(
	idLeaderboard VARCHAR(30) NOT NULL,
	PRIMARY KEY(idLeaderboard)
);

DROP TABLE IF EXISTS Liga;
CREATE TABLE Liga
(
	elo VARCHAR(30) NOT NULL,
	idLeaderboard VARCHAR(30) NOT NULL,
	FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(elo)
);

DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario
(
	email VARCHAR(50) NOT NULL,
	nomeUser VARCHAR(50) NOT NULL,
	qtXp INTEGER NOT NULL,
	idLeaderboard VARCHAR(30) NOT NULL,
	elo VARCHAR(30) NOT NULL,
	idForum VARCHAR(30),
	emailQuemBaniu VARCHAR(50),
	FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (elo) REFERENCES Liga(elo)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (idForum) REFERENCES Forum(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (emailQuemBaniu) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(email)
);

DROP TABLE IF EXISTS Item;
CREATE TABLE Item
(
	nomeItem VARCHAR(50) NOT NULL,
	preco INTEGER NOT NULL,
	PRIMARY KEY(nomeItem)
);

DROP TABLE IF EXISTS Compra;
CREATE TABLE Compra
(
	quantidade INTEGER NOT NULL,
	nomeItem VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeItem) REFERENCES Item(nomeItem)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY (nomeItem, email)
);

DROP TABLE IF EXISTS Achievements;
CREATE TABLE Achievements
(
	nome VARCHAR(100) NOT NULL,
	requisito VARCHAR(200) NOT NULL,
	PRIMARY KEY(nome)
);

DROP TABLE IF EXISTS Conquista;
CREATE TABLE Conquista
(
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY (nome) REFERENCES Achievements(nome)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY (nome, email)
);

DROP TABLE IF EXISTS Palavras;
CREATE TABLE Palavras
(
	nomePal VARCHAR(25) NOT NULL,
	nomeIdi VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeIdi) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(nomePal)
);

DROP TABLE IF EXISTS Aprende;
CREATE TABLE Aprende
(
	niveldedominio INTEGER NOT NULL,
	ultimavezvista DATE NOT NULL,
	nomePal VARCHAR(25) NOT NULL,
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomePal) REFERENCES Palavras(nomePal)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(nomePal, email)
);

DROP TABLE IF EXISTS Cursos;
CREATE TABLE Cursos
(
	nomeIdiomaOrigem VARCHAR(50) NOT NULL,
	nomeIdiomaDestino VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeIdiomaOrigem) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (nomeIdiomaDestino) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(nomeIdiomaOrigem, nomeIdiomaDestino)
);

DROP TABLE IF EXISTS Inscrito;
CREATE TABLE Inscrito
(
	nomeIdiomaOrigem VARCHAR(50) NOT NULL,
	nomeIdiomaDestino VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeIdiomaOrigem, nomeIdiomaDestino) REFERENCES Cursos(nomeIdiomaOrigem, nomeIdiomaDestino)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY (nomeIdiomaOrigem, nomeIdiomaDestino, email)
);

DROP TABLE IF EXISTS Licoes;
CREATE TABLE Licoes
(
	assunto VARCHAR(50) NOT NULL,
	fases INTEGER NOT NULL,
	nomeIdiomaOrigem VARCHAR(50) NOT NULL,
	nomeIdiomaDestino VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeIdiomaOrigem, nomeIdiomaDestino) REFERENCES Cursos(nomeIdiomaOrigem, nomeIdiomaDestino)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(assunto)
);

DROP TABLE IF EXISTS Threads;
CREATE TABLE Threads
(
	titulo VARCHAR(100) NOT NULL,
	email VARCHAR(50) NOT NULL,
	idiomaForum VARCHAR(30) NOT NULL,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(titulo)
);

DROP TABLE IF EXISTS Resposta;
CREATE TABLE Resposta
(
	titulo VARCHAR(100) NOT NULL,
	email VARCHAR(50) NOT NULL,
	conteudo VARCHAR(200) NOT NULL,
	FOREIGN KEY (titulo) REFERENCES Threads(titulo)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY (titulo, email)
);


-- A PARTIR DAQUI ESTÂO OS INSERTS

INSERT INTO Idioma VALUES ('Japonês');
INSERT INTO Idioma VALUES ('Inglês');
INSERT INTO Idioma VALUES ('Italiano');
INSERT INTO Idioma VALUES ('Espanhol');
INSERT INTO Idioma VALUES ('Dothraki');
INSERT INTO Idioma VALUES ('Alto Valiriano');

INSERT INTO Forum VALUES ('Italiano1', 'Italiano');
INSERT INTO Forum VALUES ('Inglês1', 'Inglês');
INSERT INTO Forum VALUES ('Japonês1', 'Japonês');

INSERT INTO Leaderboard VALUES ('idLeaderboard');

INSERT INTO Liga VALUES ('Ouro', 'idLeaderboard');
INSERT INTO Liga VALUES ('Prata', 'idLeaderboard');
INSERT INTO Liga VALUES ('Diamante', 'idLeaderboard');
INSERT INTO Liga VALUES ('Bronze', 'idLeaderboard');

INSERT INTO Usuario VALUES ('Caesar@Zepellin.com', 'CaesarNotSalad', 2345, 'idLeaderboard', 'Prata', 'Italiano1', NULL);
INSERT INTO Usuario VALUES ('joseph_joestar@jojo.com', 'JoJoseph', 123, 'idLeaderboard', 'Bronze', NULL, 'Caesar@Zepellin.com');
INSERT INTO Usuario VALUES ('Daenerys@targaryen.com', 'MotherOfDragons', 234, 'idLeaderboard', 'Ouro', NULL, NULL);
INSERT INTO Usuario VALUES ('Brynden@rivers.com', 'Bloodraven', 2345, 'idLeaderboard', 'Prata', NULL , NULL);
INSERT INTO Usuario VALUES ('aang@avatar.com', 'DLastAirbender', 23245, 'idLeaderboard', 'Platina', 'Japonês1', NULL);
INSERT INTO Usuario VALUES ('korra@avatar.com', 'AvatarKorra', 23241, 'idLeaderboard', 'Platina', 'Japonês1', NULL);

INSERT INTO Item VALUES ('Dobro ou Nada', 5);
INSERT INTO Item VALUES ('Streak Freeze', 10);

INSERT INTO Compra VALUES(2, 'Streak Freeze', 'joseph_joestar@jojo.com');
INSERT INTO Compra VALUES(1, 'Streak Freeze', 'Daenerys@targaryen.com');
INSERT INTO Compra VALUES(3, 'Dobro ou Nada', 'Brynden@rivers.com');

INSERT INTO Achievements VALUES ('Mago', 'Ganhe 5000XP');
INSERT INTO Achievements VALUES ('Estudioso', 'Aprenda 50 novas palavras em um só curso');
INSERT INTO Achievements VALUES ('Poliglota', 'Aprenda 50 novas palavras em mais de 3 cursos');

INSERT INTO Conquista VALUES ('Mago', 'joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Estudioso', 'joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Poliglota', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Estudioso', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago', 'Brynden@rivers.com');
INSERT INTO Conquista VALUES ('Poliglota', 'Brynden@rivers.com');

INSERT INTO Palavras VALUES('Magho', 'Dothraki');
INSERT INTO Palavras VALUES('Estudioso', 'Japonês');
INSERT INTO Palavras VALUES('Refrigerante', 'Inglês');
INSERT INTO Palavras VALUES('Mago', 'Inglês');
INSERT INTO Palavras VALUES('Potato', 'Inglês');

INSERT INTO Aprende VALUES (10, '2012-12-12', 'Potato', 'joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES (6, '2012-12-12', 'Estudioso', 'joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES (6, '2012-12-12', 'Potato', 'Daenerys@targaryen.com');
INSERT INTO Aprende VALUES (7, '2012-12-12', 'Magho', 'Daenerys@targaryen.com');
INSERT INTO Aprende VALUES (10, '2012-12-12', 'Estudioso', 'Daenerys@targaryen.com');

INSERT INTO Cursos VALUES ('Italiano', 'Espanhol');
INSERT INTO Cursos VALUES ('Japonês', 'Inglês');
INSERT INTO Cursos VALUES ('Inglês', 'Japonês');
INSERT INTO Cursos VALUES ('Inglês', 'Dothraki');
INSERT INTO Cursos VALUES ('Inglês', 'Alto Valiriano');
INSERT INTO Cursos VALUES ('Espanhol', 'Inglês');
INSERT INTO Cursos VALUES ('Italiano', 'Inglês');
INSERT INTO Cursos VALUES ('Italiano', 'Alemão');

INSERT INTO Inscrito VALUES('Inglês', 'Japonês', 'joseph_joestar@jojo.com');
INSERT INTO Inscrito VALUES('Inglês', 'Dothraki', 'Daenerys@targaryen.com');
INSERT INTO Inscrito VALUES('Inglês', 'Alto Valiriano', 'Brynden@rivers.com');

INSERT INTO Licoes VALUES ('Animais', 1, 'Italiano', 'Espanhol');
INSERT INTO Licoes VALUES ('Comida', 2, 'Japonês', 'Inglês');
INSERT INTO Licoes VALUES ('Família', 3, 'Italiano', 'Inglês');
INSERT INTO Licoes VALUES ('Cores', 3, 'Espanhol', 'Inglês');

INSERT INTO Threads VALUES ('Assunto 1', 'joseph_joestar@jojo.com', 'Inglês');
INSERT INTO Threads VALUES ('Assunto 2', 'Daenerys@targaryen.com', 'Inglês');
INSERT INTO Threads VALUES ('Assunto 3', 'Daenerys@targaryen.com', 'Espanhol');

INSERT INTO Resposta VALUES ('Assunto 1', 'joseph_joestar@jojo.com', 'Que post lixo');
INSERT INTO Resposta VALUES ('Assunto 2', 'Brynden@rivers.com', 'Boa dica');
INSERT INTO Resposta VALUES ('Assunto 3', 'Brynden@rivers.com', 'Interessante');


-- A PARTIR DAQUI ESTÂO AS CONSULTAS

SELECT nomeUser, elo, Conquista.nome
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Conquista ON Conquista.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Inglês'
	ORDER BY Conquista.nome;


-- Blaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
SELECT elo
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Conquista ON Conquista.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Inglês' AND Conquista.nome = 'Poliglota'
	GROUP BY elo;

-- Mostra os usuário que aprederam mais que uma palavra e quantas palavras eles aprederam, em ordem descendente.
SELECT nomeUser, COUNT(nomePal)
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Aprende ON Aprende.email = Usuario.email
	GROUP BY nomeUser HAVING COUNT(nomePal) > 1
	ORDER BY COUNT(nomePal) DESC;

-- Blaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
SELECT conteudo
	FROM Resposta
WHERE Resposta.titulo IN (
	SELECT titulo
		FROM Usuario
		JOIN Inscrito ON Usuario.email = Inscrito.email
		JOIN Threads ON Threads.email = Usuario.email
	WHERE nomeUser = 'MotherOfDragons'
);

-- Mostra quantas conquistas os usuarios que compraram o item 'Streak Freeze' possuem.
SELECT Usuario.nomeUser, COUNT(Conquista.nome)
	FROM Usuario
	LEFT JOIN Conquista ON Usuario.email = Conquista.email
WHERE Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Inscrito ON Usuario.email = Inscrito.email
		JOIN Compra ON Compra.email = Usuario.email
	WHERE nomeItem = 'Streak Freeze'
)
GROUP BY Usuario.email;

-- Blaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
SELECT nomeItem
	FROM Compra
WHERE Compra.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Inscrito ON Usuario.email = Inscrito.email
	WHERE Inscrito.email = 'joseph_joestar@jojo.com'
);

SELECT nomeUser
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Compra ON Compra.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Inglês' AND NOT EXISTS (
	SELECT DISTINCT Compra.email
	WHERE nomeItem = 'Dobro ou Nada'
);
