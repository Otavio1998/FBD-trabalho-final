
DROP TABLE IF EXISTS Forum;
CREATE TABLE Forum
(idiomaForum VARCHAR(30) NOT NULL,
PRIMARY KEY(idiomaForum));

DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario
(email VARCHAR(50) NOT NULL,
nomeUser VARCHAR(50) NOT NULL,
idiomaForum VARCHAR(30),
idLeaderboard VARCHAR(30),
elo VARCHAR(30),
qtXp INTEGER,
FOREIGN KEY (idiomaForum) REFERENCES Forum(idiomaForum),
FOREIGN KEY (idLeaderboard) REFERENCES Leaderboard(idLeaderboard),
FOREIGN KEY (email) REFERENCES Usuario(email),
FOREIGN KEY (elo) REFERENCES Liga(elo),
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
FOREIGN KEY (nomeIdiomaDestino) REFERENCES Idioma(nomeIdi)
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
conteudo VARCHAR(200),
PRIMARY KEY (titulo,email),
FOREIGN KEY (titulo) REFERENCES Threads(titulo),
FOREIGN KEY (email) REFERENCES Usuario(email)); -- Acho que aqui está errado o uso de estudantes, mas não sei como fazer os usários daí

DROP TABLE IF EXISTS Aprende;
CREATE TABLE Aprende
(nomePal VARCHAR(25) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY(nomePal,email),
FOREIGN KEY (nomePal) REFERENCES Palavras(nomePal),
FOREIGN KEY(email) REFERENCES Usuario(email));


INSERT INTO Usuario VALUES ('joseph_joestar@jojo.com','JoJoseph','Italiano','idLeaderboard','Bronze',123);
INSERT INTO Usuario VALUES ('Daenerys@targaryen.com','MotherOfDragons','Italiano','idLeaderboard','Ouro', 234);
INSERT INTO Usuario VALUES ('Brynden@rivers.com','Bloodraven','Italiano','idLeaderboard','Prata',2345);

INSERT INTO Aprende VALUES ('Potato','joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES ('Estudioso','joseph_joestar@jojo.com');
INSERT INTO Aprende VALUES ('Potato','Daenerys@targaryen.com');
INSERT INTO Aprende VALUES ('Mago','Daenerys@targaryen.com');
INSERT INTO Aprende VALUES ('Estudioso','Daenerys@targaryen.com');
INSERT INTO Aprende VALUES ('Mago','Brynden@rivers.com');
INSERT INTO Aprende VALUES ('Livro','Brynden@rivers.com');

INSERT INTO Achievements VALUES ('Mago','Ganhe 5000XP');
INSERT INTO Achievements VALUES ('Estudioso','Aprenda 50 novas palavras em um só curso');
INSERT INTO Achievements VALUES ('Poliglota','Aprenda 50 novas palavras em mais de 3 cursos');

INSERT INTO Conquista VALUES ('Mago','joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Estudioso','joseph_joestar@jojo.com');
INSERT INTO Conquista VALUES ('Poliglota','Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago','Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Estudioso','Daenerys@targaryen.com');
INSERT INTO Conquista VALUES ('Mago','Brynden@rivers.com');
INSERT INTO Conquista VALUES ('Poliglota','Brynden@rivers.com');



INSERT INTO Threads VALUES ('Melhores apps para aprender Japonês', 'EstudanteDeJapones123@gmail.com', 'Português');
INSERT INTO Threads VALUES ('Qual o idioma mais difícil de aprender?', 'Estudante123@gmail.com','Português');
INSERT INTO Threads VALUES ('Assunto 1', 'joseph_joestar@jojo.com','Inglês');
INSERT INTO Threads VALUES ('Assunto 2', 'Daenerys@targaryen.com','Inglês');
INSERT INTO Threads VALUES ('Assunto 3', 'Daenerys@targaryen.com','Espanhol');
INSERT INTO Threads VALUES ('Assunto 4', 'Estudante124@gmail.com','Japonês');

INSERT INTO Resposta VALUES ('Assunto 1', 'joseph_joestar@jojo.com','Que post lixo');
INSERT INTO Resposta VALUES ('Assunto 2', 'Daenerys@targaryen.com','Boa dica');
INSERT INTO Resposta VALUES ('Assunto 3', 'Daenerys@targaryen.com','Interessante');


INSERT INTO Idioma VALUES ('Japonês');
INSERT INTO Idioma VALUES ('Inglês');
INSERT INTO Idioma VALUES ('Italiano');
INSERT INTO Idioma VALUES ('Espanhol');


INSERT INTO Item VALUES ('Dobro ou Nada', 5);
INSERT INTO Item VALUES ('Streak Freeze', 10);

INSERT INTO Licoes VALUES ('Animais', 1, 'Inglês', 'Italiano');
INSERT INTO Licoes VALUES ('Comida', 2, 'Espanhol', 'Italiano');
INSERT INTO Licoes VALUES ('Família', 3,'Inglês', 'Esperanto');
INSERT INTO Licoes VALUES ('Cores', 3,'Espanhol', 'Inglês');

INSERT INTO Cursos VALUES ('Italiano','Espanhol');
INSERT INTO Cursos VALUES ('Japonês', 'Inglês');
INSERT INTO Cursos VALUES ('Espanhol', 'Inglês');
INSERT INTO Cursos VALUES ('Italiano','Inglês');
INSERT INTO Cursos VALUES ('Italiano','Alemão');

INSERT INTO Palavras VALUES('Batata',10,'2012-12-12', 'Italiano');
INSERT INTO Palavras VALUES('Hamburguer',6,'2012-12-12','Italiano');
INSERT INTO Palavras VALUES('Refrigerante',7,'2012-12-12','Francês');
INSERT INTO Palavras VALUES('Potato',10,'2012-12-12', 'Inglês');



INSERT INTO Forum VALUES ('Italiano');
INSERT INTO Forum VALUES ('Inglês');
INSERT INTO Forum VALUES ('Japonês');

INSERT INTO Liga VALUES ('Ouro','idLeaderboard');
INSERT INTO Liga VALUES ('Prata','idLeaderboard');
INSERT INTO Liga VALUES ('Diamante','idLeaderboard');
INSERT INTO Liga VALUES ('Cobre','idLeaderboard');

INSERT INTO Inscrito VALUES('Inglês','joseph_joestar@jojo.com');
INSERT INTO Inscrito VALUES('Inglês','Daenerys@targaryen.com');
INSERT INTO Inscrito VALUES('Inglês','Brynden@rivers.com');

INSERT INTO Compra VALUES('Streak Freeze', 'joseph_joestar@jojo.com',2);
INSERT INTO Compra VALUES('Dobro ou Nada', 'joseph_joestar@jojo.com',3);
INSERT INTO Compra VALUES('Streak Freeze', 'Daenerys@targaryen.com',1);


INSERT INTO Leaderboard VALUES ('Platina','idLeaderboard');


--                            A PARTIR DAQUI ESTÂO AS CONSULTAS

--SELECT nomeUser,elo,Conquista.nome FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email JOIN Conquista ON  Conquista.email =  Usuario.email WHERE Inscrito.idiomaCurso = 'Inglês' ORDER BY Conquista.nome;

-- SELECT elo FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email JOIN Conquista ON  Conquista.email =  Usuario.email WHERE Inscrito.idiomaCurso = 'Inglês' AND Conquista.nome = 'Poliglota'  GROUP BY elo;


-- SELECT nomeUser FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email JOIN Aprende ON  Aprende.email =  Usuario.email WHERE Inscrito.idiomaCurso = 'Inglês' GROUP BY nomeUser HAVING Aprende.nomePal = 'Potato'; 


-- SELECT conteudo FROM Resposta WHERE Resposta.titulo =  (SELECT titulo FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email JOIN Threads ON Threads.email = Usuario.email WHERE nomeUser = 'MotherOfDragons'); 

-- SELECT Conquista.nome FROM Conquista WHERE Conquista.email =  (SELECT Usuario.email FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email JOIN Compra ON Compra.email = Usuario.email WHERE nomeItem = 'Streak Freeze'); 

-- SELECT nomeItem FROM Compra WHERE Compra.email = (SELECT Usuario.email FROM Usuario JOIN Inscrito ON Usuario.email = Inscrito.email WHERE Inscrito.email = 'joseph_joestar@jojo.com');





