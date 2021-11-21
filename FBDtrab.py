import mysql.connector

#conexão com a database
db = mysql.connector.connect(host = 'localhost', user = 'root', passwd = 'fbdraiz', database = 'AppAprendizado')

myCursor = db.cursor()

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
#executescript("C:/Users/Home/Documents/tabelas.sql") <- trocar o endereço caso for rodar em outro PC
#db.commit()

#execução de um script com a inserção das instâncias
#executescript("C:/Users/Home/Documents/instancias.sql") <- trocar o endereço caso for rodar em outro PC
#db.commit()





