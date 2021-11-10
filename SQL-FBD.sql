CREATE TABLE Estudantes
(email VARCHAR(50) NOT NULL,
nomeUser VARCHAR(50) NOT NULL,
listadeidiomas TEXT[],
PRIMARY KEY(email));

CREATE TABLE Moderadores
(emailMod VARCHAR(50) NOT NULL,
nomeMod VARCHAR(50) NOT NULL,
PRIMARY KEY(emailMod));


CREATE TABLE Achievements
(nome VARCHAR(100) NOT NULL,
requisito VARCHAR(200) NOT NULL,
PRIMARY KEY(nome));

CREATE TABLE Threads
(titulo VARCHAR(100) NOT NULL,
autor VARCHAR(50) NOT NULL,
PRIMARY KEY(titulo));

CREATE TABLE Cursos
(idiomaCurso VARCHAR(30) NOT NULL,
PRIMARY KEY(idiomaCurso));

CREATE TABLE Linguas
(nomeLin VARCHAR(50) NOT NULL,
PRIMARY KEY(nomeLin));

CREATE TABLE Item
(nomeItem VARCHAR(50) NOT NULL,
preco INTEGER NOT NULL,
PRIMARY KEY(nomeItem));

CREATE TABLE Licoes
(assunto VARCHAR(50) NOT NULL,
fases INTEGER  NOT NULL,
PRIMARY KEY(assunto));

CREATE TABLE Palavras
(nomePal VARCHAR(25) NOT NULL,
niveldedominio INTEGER NOT NULL,
ultimavezvista   DATE NOT NULL,
PRIMARY KEY(nomePal));

CREATE TABLE Forum
(idiomaForum VARCHAR(30) NOT NULL,
PRIMARY KEY(idiomaForum));



INSERT INTO Estudantes VALUES ('joseph_joestar@jojo.com','JoJoseph', '{"Japonês","Inglês"}');
INSERT INTO Estudantes VALUES ('Daenerys@targaryen.com','MotherOfDragons', '{"Dothraki","Inglês"}');
INSERT INTO Estudantes VALUES ('Brynden@rivers.com','Bloodraven', '{"Alto Valiriano","Inglês"}');

INSERT INTO Moderadores VALUES ('jotaro_kujo@jojo.com','JoJotaro');
INSERT INTO Moderadores VALUES ('aang@avatar.com','DLastAirbender');
INSERT INTO Moderadores VALUES ('korra@avatar.com','AvatarKorra');

INSERT INTO Achievements VALUES ('Mago','Ganhe 5000XP');
INSERT INTO Achievements VALUES ('Estudioso','Aprenda 50 novas palavras em um só curso');
INSERT INTO Achievements VALUES ('Poliglota','Aprenda 50 novas palavras em mais de 3 cursos');


INSERT INTO Threads VALUES ('Melhores apps para aprender Japonês', 'EstudanteDeJapones123');
INSERT INTO Threads VALUES ('Qual o idioma mais difícil de aprender?', 'Estudante123');

INSERT INTO Linguas VALUES ('Japonês');
INSERT INTO Linguas VALUES ('Inglês');
INSERT INTO Linguas VALUES ('Italiano');

INSERT INTO Item VALUES ('Dobro ou Nada', 5);
INSERT INTO Item VALUES ('Streak Freeze', 10);

INSERT INTO Licoes VALUES ('Animais', 1);
INSERT INTO Licoes VALUES ('Comida', 2);
INSERT INTO Licoes VALUES ('Família', 3);

INSERT INTO Cursos VALUES ('Italiano');
INSERT INTO Cursos VALUES ('Japonês');
INSERT INTO Cursos VALUES ('Espanhol');

INSERT INTO Palavras VALUES('Batata',10,'2012-12-12');
INSERT INTO Palavras VALUES('Hamburguer',6,'2012-12-12');
INSERT INTO Palavras VALUES('Refrigerante',7,'2012-12-12');

INSERT INTO Forum VALUES ('Italiano');
INSERT INTO Forum VALUES ('Inglês');
INSERT INTO Forum VALUES ('Japonês');


SELECT * FROM Palavras WHERE niveldedominio = 10;