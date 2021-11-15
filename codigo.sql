DROP TABLE IF EXISTS Idioma;
CREATE TABLE Idioma
(
	nomeIdi VARCHAR(50) NOT NULL,
	PRIMARY KEY(nomeIdi)
);

DROP TABLE IF EXISTS Forum;
CREATE TABLE Forum
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
	nomeUser VARCHAR(50) NOT NULL UNIQUE,
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
	id VARCHAR(25) NOT NULL,
	nomePal VARCHAR(25) NOT NULL,
	nomeIdi VARCHAR(50) NOT NULL,
	FOREIGN KEY (nomeIdi) REFERENCES Idioma(nomeIdi)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Aprende;
CREATE TABLE Aprende
(
	niveldedominio INTEGER NOT NULL,
	ultimavezvista DATE NOT NULL,
	idPalavra VARCHAR(25) NOT NULL,
	email VARCHAR(50) NOT NULL,
	FOREIGN KEY (idPalavra) REFERENCES Palavras(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY(email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	PRIMARY KEY(idPalavra, email)
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
	idForum VARCHAR(30) NOT NULL,
	FOREIGN KEY (email) REFERENCES Usuario(email)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (idForum) REFERENCES Forum(id)
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


-- A PARTIR DAQUI ESTÃO OS INSERTS

INSERT INTO Idioma VALUES ('Japones');
INSERT INTO Idioma VALUES ('Ingles');
INSERT INTO Idioma VALUES ('Italiano');
INSERT INTO Idioma VALUES ('Espanhol');
INSERT INTO Idioma VALUES ('Dothraki');
INSERT INTO Idioma VALUES ('Alto Valiriano');

INSERT INTO Forum VALUES ('Italiano1', 'Italiano');
INSERT INTO Forum VALUES ('Ingles1', 'Ingles');
INSERT INTO Forum VALUES ('Japones1', 'Japones');
INSERT INTO Forum VALUES ('Espanhol1', 'Espanhol');

INSERT INTO Leaderboard VALUES ('idLeaderboard');

INSERT INTO Liga VALUES ('Ouro', 'idLeaderboard');
INSERT INTO Liga VALUES ('Prata', 'idLeaderboard');
INSERT INTO Liga VALUES ('Diamante', 'idLeaderboard');
INSERT INTO Liga VALUES ('Bronze', 'idLeaderboard');

INSERT INTO Usuario VALUES ('Caesar@Zepellin.com', 'CaesarNotSalad', 2345, 'idLeaderboard', 'Prata', 'Ingles1', NULL);
INSERT INTO Usuario VALUES ('joseph_joestar@jojo.com', 'JoJoseph', 123, 'idLeaderboard', 'Bronze', NULL, 'Caesar@Zepellin.com');
INSERT INTO Usuario VALUES ('Daenerys@targaryen.com', 'MotherOfDragons', 234, 'idLeaderboard', 'Ouro', NULL, NULL);
INSERT INTO Usuario VALUES ('Brynden@rivers.com', 'Bloodraven', 2345, 'idLeaderboard', 'Prata', NULL , 'korra@avatar.com');
INSERT INTO Usuario VALUES ('aang@avatar.com', 'DLastAirbender', 23245, 'idLeaderboard', 'Platina', 'Japones1', NULL);
INSERT INTO Usuario VALUES ('korra@avatar.com', 'AvatarKorra', 23241, 'idLeaderboard', 'Platina', 'Japones1', NULL);
INSERT INTO Usuario VALUES ('zuko@notavatar.com', 'LordZuko', 41, 'idLeaderboard', 'Bronze', NULL, 'aang@avatar.com');

INSERT INTO Item VALUES ('Dobro ou Nada', 5);
INSERT INTO Item VALUES ('Dobro ou Nada Gold', 7);
INSERT INTO Item VALUES ('Streak Freeze', 10);

INSERT INTO Compra VALUES(2, 'Streak Freeze', 'joseph_joestar@jojo.com');
INSERT INTO Compra VALUES(1, 'Streak Freeze', 'Daenerys@targaryen.com');
INSERT INTO Compra VALUES(2, 'Dobro ou Nada', 'joseph_joestar@jojo.com');
INSERT INTO Compra VALUES(3, 'Dobro ou Nada', 'Brynden@rivers.com');

INSERT INTO Achievements VALUES ('Mago', 'Ganhe 5000XP');
INSERT INTO Achievements VALUES ('Estudioso', 'Aprenda 50 novas palavras em um so curso');
INSERT INTO Achievements VALUES ('Poliglota', 'Aprenda 50 novas palavras em mais de 3 cursos');
INSERT INTO Achievements VALUES ('Estrategista', 'Leia uma dica');

INSERT INTO Conquista VALUES ('Estrategista', 'joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Mago', 'joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Estudioso', 'joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Poliglota', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Estudioso', 'Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago', 'Brynden@rivers.com');
INSERT INTO Conquista VALUES ('Poliglota', 'Brynden@rivers.com');

INSERT INTO Palavras VALUES(0, 'Magho', 'Dothraki');
INSERT INTO Palavras VALUES(1, 'Estudioso', 'Japones');
INSERT INTO Palavras VALUES(2, 'Refrigerante', 'Ingles');
INSERT INTO Palavras VALUES(3, 'Mage', 'Ingles');
INSERT INTO Palavras VALUES(4, 'Potato', 'Ingles');

INSERT INTO Aprende VALUES (10, '2012-12-12', 4, 'joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES (6, '2012-12-12', 1, 'joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES (6, '2012-12-12', 4, 'Daenerys@targaryen.com');
INSERT INTO Aprende VALUES (9, '2012-12-12', 3, 'Daenerys@targaryen.com');
INSERT INTO Aprende VALUES (7, '2012-12-12', 0, 'Daenerys@targaryen.com');
INSERT INTO Aprende VALUES (10, '2012-12-12', 1, 'Daenerys@targaryen.com');

INSERT INTO Cursos VALUES ('Italiano', 'Espanhol');
INSERT INTO Cursos VALUES ('Japones', 'Ingles');
INSERT INTO Cursos VALUES ('Ingles', 'Japones');
INSERT INTO Cursos VALUES ('Ingles', 'Dothraki');
INSERT INTO Cursos VALUES ('Ingles', 'Alto Valiriano');
INSERT INTO Cursos VALUES ('Espanhol', 'Ingles');
INSERT INTO Cursos VALUES ('Italiano', 'Ingles');
INSERT INTO Cursos VALUES ('Italiano', 'Alemao');

INSERT INTO Inscrito VALUES('Ingles', 'Japones', 'joseph_joestar@jojo.com');
INSERT INTO Inscrito VALUES('Italiano', 'Japones', 'zuko@notavatar.com');
INSERT INTO Inscrito VALUES('Ingles', 'Dothraki', 'Daenerys@targaryen.com');
INSERT INTO Inscrito VALUES('Ingles', 'Alto Valiriano', 'Brynden@rivers.com');

INSERT INTO Licoes VALUES ('Animais', 1, 'Italiano', 'Espanhol');
INSERT INTO Licoes VALUES ('Comida', 2, 'Japones', 'Ingles');
INSERT INTO Licoes VALUES ('Familia', 3, 'Italiano', 'Ingles');
INSERT INTO Licoes VALUES ('Cores', 3, 'Espanhol', 'Ingles');

INSERT INTO Threads VALUES ('Assunto 1', 'joseph_joestar@jojo.com', 'Ingles1');
INSERT INTO Threads VALUES ('Assunto 2', 'Daenerys@targaryen.com', 'Ingles1');
INSERT INTO Threads VALUES ('Assunto 3', 'Daenerys@targaryen.com', 'Japones1');
INSERT INTO Threads VALUES ('O certo eh arroz em cima do feijao, otarios.', 'Brynden@rivers.com', 'Japones1');

INSERT INTO Resposta VALUES ('Assunto 1', 'joseph_joestar@jojo.com', 'Que post lixo');
INSERT INTO Resposta VALUES ('Assunto 2', 'Brynden@rivers.com', 'Boa dica');
INSERT INTO Resposta VALUES ('Assunto 3', 'Brynden@rivers.com', 'Interessante');
INSERT INTO Resposta VALUES ('Assunto 3', 'zuko@notavatar.com', 'Omae wa mo shindeiru baka.');


-- VIEW

DROP VIEW IF EXISTS UsuariosBanidosESeusBanidores;
CREATE VIEW UsuariosBanidosESeusBanidores AS
	SELECT UsuarioBanido.email AS usuarioBanido_email,
	UsuarioBanido.nomeUser AS usuarioBanido_nomeUser,
	UsuarioBanido.qtXp AS usuarioBanido_qtXp,
	UsuarioBanido.idLeaderboard AS usuarioBanido_idLeaderboard,
	UsuarioBanido.elo AS usuarioBanido_elo,
	UsuarioBanido.emailQuemBaniu AS usuarioBanido_emailQuemBaniu,
	Banidor.email AS banidor_email,
	Banidor.nomeUser AS banidor_nomeUser,
	Banidor.qtXp AS banidor_qtXp,
	Banidor.idLeaderboard AS banidor_idLeaderboard,
	Banidor.elo AS banidor_elo,
	Banidor.idForum AS banidor_idForum
		FROM Usuario AS UsuarioBanido
		JOIN Usuario AS Banidor ON UsuarioBanido.emailQuemBaniu = Banidor.email;


-- A PARTIR DAQUI ESTÃO AS CONSULTAS

-- Mostra quantas conquistas os usuarios que compraram o item 'Streak Freeze' possuem.
SELECT Usuario.nomeUser, COUNT(Conquista.nome)
	FROM Usuario
	LEFT JOIN Conquista ON Usuario.email = Conquista.email
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Compra ON Compra.email = Usuario.email
	WHERE nomeItem = 'Streak Freeze'
GROUP BY Usuario.email;

-- Mostra os usuário falantes de inglês que aprenderam mais que uma palavra e quantas palavras eles aprederam, em ordem descendente.
SELECT nomeUser, COUNT(Aprende.idPalavra)
	FROM Usuario
	JOIN Inscrito ON Inscrito.email = Usuario.email
	JOIN Aprende ON Aprende.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles'
	GROUP BY nomeUser HAVING COUNT(Aprende.idPalavra) > 1
	ORDER BY COUNT(Aprende.idPalavra) DESC;

-- Mostra os estudantes de japonês que compraram os itens 'Dobro ou Nada' e 'Streak Freeze'.
SELECT Usuario.email
	FROM Usuario
	JOIN Inscrito ON Inscrito.email = Usuario.email
	JOIN Compra ON Compra.email = Usuario.email
WHERE Inscrito.nomeIdiomaDestino = 'Japones' AND nomeItem = 'Streak Freeze' AND Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Inscrito ON Inscrito.email = Usuario.email
		JOIN Compra ON Compra.email = Usuario.email
	WHERE nomeItem = 'Dobro ou Nada'
);

-- Mostra os estudantes que aprenderam ambas palavras Potato e Mago.
SELECT nomeUser
	FROM Usuario
	JOIN Aprende ON Aprende.email = Usuario.email
	JOIN Palavras ON Palavras.id = Aprende.idPalavra
WHERE nomePal = 'Potato' AND Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Aprende ON Aprende.email = Usuario.email
		JOIN Palavras ON Palavras.id = Aprende.idPalavra
	WHERE nomePal = 'Mago'
);

-- Mostra os usuarios falantes de inglês que não possuem ambos itens 'Dobro ou Nada' e 'Dobro ou Nada Gold'.
SELECT nomeUser
	FROM Usuario
	JOIN Inscrito ON Inscrito.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles' AND NOT EXISTS (
		SELECT nomeItem
			FROM Compra
		WHERE Compra.email = Usuario.email AND nomeItem = 'Dobro ou Nada'
	INTERSECT
		SELECT nomeItem
			FROM Compra
		WHERE Compra.email = Usuario.email AND nomeItem = 'Dobro ou Nada Gold'
);

-- Mostra todas as postagens do usuário banido dentro da jurisdição do moderador que o baniu (serve para auditorar se foi um banimento justo).
SELECT UsuariosBanidosESeusBanidores.banidor_nomeUser, UsuariosBanidosESeusBanidores.usuarioBanido_nomeUser, Resposta.conteudo, Threads.titulo, Forum.id, Forum.idiomaForum
	FROM UsuariosBanidosESeusBanidores
	JOIN Resposta ON Resposta.email = UsuariosBanidosESeusBanidores.usuarioBanido_email
	JOIN Threads ON Threads.titulo = Resposta.titulo
	JOIN Forum ON Forum.id = Threads.idForum AND Forum.id = UsuariosBanidosESeusBanidores.banidor_idForum;

-- Mostra todas as threads criadas pelo usuário banido dentro da jurisdição do moderador que o baniu (também é essencial para auditorar se foi um banimento justo, pois caso o usuário não tenha postado nada de errado, ainda assim ele pode ter criado uma thread de título ofensivo).
SELECT UsuariosBanidosESeusBanidores.banidor_nomeUser, UsuariosBanidosESeusBanidores.usuarioBanido_nomeUser, Threads.titulo, Forum.id, Forum.idiomaForum
	FROM UsuariosBanidosESeusBanidores
	JOIN Threads ON Threads.email = usuarioBanido_email
	JOIN Forum ON Forum.id = Threads.idForum AND Forum.id = UsuariosBanidosESeusBanidores.banidor_idForum;

-- Mostra o usuario, elo e as conquistas dos usuarios que falam inglês.
SELECT nomeUser, elo, Conquista.nome
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Conquista ON Conquista.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles'
	ORDER BY Conquista.nome;

-- Mostra as respostas recebidas nas threads postadas pelo usuario 'MotherOfDragons'.
SELECT conteudo
	FROM Resposta
	JOIN Threads ON Threads.titulo = Resposta.titulo
	JOIN Usuario ON Usuario.email = Threads.email
WHERE nomeUser = 'MotherOfDragons';

-- Mostra o elo dos usuários que falam inglês e possuem a conquista 'Poliglota'.
SELECT elo
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Conquista ON Conquista.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles' AND Conquista.nome = 'Poliglota'
	GROUP BY elo;

