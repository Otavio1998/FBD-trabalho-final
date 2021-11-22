import mysql.connector

#conexão com a database
db = mysql.connector.connect(host = 'localhost', user = 'root', passwd = 'fbdraiz', database = 'AppAprendizado')

myCursor = db.cursor(prepared = True)

#myCursor.execute("CREATE DATABASE AppAprendizado") <- comentado pois a database ja foi criada


def executescript(nomearq):
    file = open(nomearq, 'r')
    sqlfile = file.read()
    file.close()
    sqlcomm = sqlfile.split(';')
    for command in sqlcomm:
        try:
            if command.strip() != '':
                myCursor.execute(command)
        except IOError as msg:
            print('command skipped: ',msg)


#execução de um script com a criação das tabelas
#executescript("C:/Users/Home/Documents/tabelas.sql") 
#db.commit()

#execução de um script com a inserção das instâncias
#executescript("C:/Users/Home/Documents/instancias2.sql") 
#db.commit()

myCursor.execute("DROP VIEW IF EXISTS UsuariosBanidosESeusBanidores")
myCursor.execute("""
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
		JOIN Usuario AS Banidor ON UsuarioBanido.emailQuemBaniu = Banidor.email""")


#cconsultas que utlizam a visão definida acima

myCursor.execute("""SELECT UsuariosBanidosESeusBanidores.banidor_nomeUser, UsuariosBanidosESeusBanidores.usuarioBanido_nomeUser, Resposta.conteudo, Threads.titulo, Forum.id, Forum.idiomaForum
	FROM UsuariosBanidosESeusBanidores
	JOIN Resposta ON Resposta.email = UsuariosBanidosESeusBanidores.usuarioBanido_email
	JOIN Threads ON Threads.titulo = Resposta.titulo
	JOIN Forum ON Forum.id = Threads.idForum AND Forum.id = UsuariosBanidosESeusBanidores.banidor_idForum""")


myCursor.execute("""SELECT UsuariosBanidosESeusBanidores.banidor_nomeUser, UsuariosBanidosESeusBanidores.usuarioBanido_nomeUser, Threads.titulo, Forum.id, Forum.idiomaForum
	FROM UsuariosBanidosESeusBanidores
	JOIN Threads ON Threads.email = usuarioBanido_email
	JOIN Forum ON Forum.id = Threads.idForum AND Forum.id = UsuariosBanidosESeusBanidores.banidor_idForum""")    

#consultas com parametros

item = input("digite o nome do item: ")

myCursor.execute("""SELECT Usuario.nomeUser, COUNT(Conquista.nome)
	FROM Usuario
	LEFT JOIN Conquista ON Usuario.email = Conquista.email
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Compra ON Compra.email = Usuario.email
	WHERE nomeItem = %s
GROUP BY Usuario.email""", (item,))



nomeuser = input("digite o nome do usuario: ")

myCursor.execute("""SELECT conteudo
	FROM Resposta
	JOIN Threads ON Threads.titulo = Resposta.titulo
	JOIN Usuario ON Usuario.email = Threads.email
WHERE nomeUser = %s""", (nomeuser,))



palavra1 = input("Digite a palavra: ")
palavra2 = input("Digite a palavra: ")


myCursor.execute("""SELECT nomeUser
	FROM Usuario
	JOIN Aprende ON Aprende.email = Usuario.email
	JOIN Palavras ON Palavras.id = Aprende.idPalavra
WHERE nomePal = %s AND Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Aprende ON Aprende.email = Usuario.email
		JOIN Palavras ON Palavras.id = Aprende.idPalavra
	WHERE nomePal = %s
)""", (palavra1, palavra2))

#consultas sem parametros 
myCursor.execute("""SELECT nomeUser, COUNT(Aprende.idPalavra)
	FROM Usuario
	JOIN Inscrito ON Inscrito.email = Usuario.email
	JOIN Aprende ON Aprende.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles'
	GROUP BY nomeUser HAVING COUNT(Aprende.idPalavra) > 1
	ORDER BY COUNT(Aprende.idPalavra) DESC""")

myCursor.execute("""SELECT Usuario.email
	FROM Usuario
	JOIN Inscrito ON Inscrito.email = Usuario.email
	JOIN Compra ON Compra.email = Usuario.email
WHERE Inscrito.nomeIdiomaDestino = 'Japones' AND nomeItem = 'Streak Freeze' AND Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Inscrito ON Inscrito.email = Usuario.email
		JOIN Compra ON Compra.email = Usuario.email
	WHERE nomeItem = 'Dobro ou Nada'
)""")

myCursor.execute("""SELECT nomeUser
	FROM Usuario
	JOIN Aprende ON Aprende.email = Usuario.email
	JOIN Palavras ON Palavras.id = Aprende.idPalavra
WHERE nomePal = 'Potato' AND Usuario.email IN (
	SELECT Usuario.email
		FROM Usuario
		JOIN Aprende ON Aprende.email = Usuario.email
		JOIN Palavras ON Palavras.id = Aprende.idPalavra
	WHERE nomePal = 'Mago'
)""")

myCursor.execute("""SELECT nomeUser
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
)""")


myCursor.execute("""SELECT elo
	FROM Usuario
	JOIN Inscrito ON Usuario.email = Inscrito.email
	JOIN Conquista ON Conquista.email = Usuario.email
WHERE Inscrito.nomeIdiomaOrigem = 'Ingles' AND Conquista.nome = 'Poliglota'
	GROUP BY elo""")

for x in myCursor:
    print(x)
