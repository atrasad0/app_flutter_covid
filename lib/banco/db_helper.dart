import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:sqflite/utils/utils.dart';

class DBHelper {
  static DBHelper _dBhelper; //instancia da classe privada
  static Database _database; //instancia do BD privada

  //Criando const para usar na criacao tabela
  static const String ID = 'id';
  static const String NOME_CIDADE = 'nome_cidade';
  static const String DES_QUARENTENA = 'desc_quarentena';
  static const String INFECTADOS = 'infectados';
  static const String RECUPERADOS = 'recuperados';
  static const String TABELA = 'tabela_cidade';
  static const String BD_NOME = 'cidade.db';

  //construtor cria uma instancia da classe
  DBHelper._createInstance(); //criando instancia da classe

  factory DBHelper() {
    if (_dBhelper == null) {
        //garantindo que vou ter somente uma instancia do DB 
      _dBhelper = DBHelper._createInstance();
    }
    return _dBhelper;

  }
  
  //future por ser uma operacao assincrona, pois pode ser que nao aconteca de dar certo as coisas por aqui 
  Future <Database> get dataBase async {
    if (_database == null) {
      _database = await iniciarBancoDado();
    }
    return _database;
  }

  Future <Database> iniciarBancoDado() async {
    //descobrindo o caminho da pasta para salvar o bd
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + BD_NOME;//armazenando o nome do banco e o caminho

    var cidadeDataBase = await openDatabase(path,version: 1,onCreate: _criaDB);
    return cidadeDataBase;
  }

  void _criaDB(Database db, int versao) async{
    String querySql ='CREATE TABLE $TABELA($ID INTEGER PRIMARY KEY AUTOINCREMENT,''$NOME_CIDADE TEXT, '
                     '$DES_QUARENTENA TEXT, ''$INFECTADOS INTEGER, ''$RECUPERADOS INTEGER)';
    await db.execute(querySql);
  }

  //inserindo uma cidade
  Future <int> insereCidade(Cidade cidade)async{

    Database db = await this.dataBase;
    var resultado = await db.insert(TABELA, cidade.toMap());
    return resultado;//retornando o id do contato
  }

  //retorna uma cidade pelo ID
  Future <Cidade> pegaUmaCidade(int id) async{
    Database db = await this.dataBase;
    List<Map> maps = await db.query(TABELA,
    columns: [ID, NOME_CIDADE,DES_QUARENTENA,INFECTADOS,RECUPERADOS], //colunas que quero retornar
    where: "$ID = ?",
    whereArgs: [id] ); //argumento recebido

    if (maps.length > 0 ){
      return Cidade.fromMap(maps.first); //primeira cidade da lista
    }
    else
      return null;

  }

  //retornando todas as cidades
  Future <List<Cidade>> pegaTodasCidades() async{

    Database db = await this.dataBase;
    var resultado = await db.query(TABELA); 
    //convertendo lista map para uma lista de objeto cidade 
    List<Cidade>listaCidades = resultado.isNotEmpty ? resultado.map((e) => Cidade.fromMap(e)).toList():[];//se resultado nao estiver vazio, meia lua pra tras
    return listaCidades;

  }

  //atualizar cidade
  Future <int> alteraCidade(Cidade cidade)async{

    Database db = await this.dataBase;
    var resultado = await db.update(TABELA, cidade.toMap(),
        where:'$ID = ?',
        whereArgs: [cidade.id]);
    return resultado;//retornando o id do contato
  }

  Future <int> excluiCidade(int id)async{

    Database db = await this.dataBase;
    var resultado = await db.delete(TABELA,
        where:'$ID = ?',
        whereArgs: [id]);
    return resultado;//retornando o id do contato
  }

  //obtem o numero deregistro no banco
  Future <int> qtdCidade()async{
    Database db = await this.dataBase;  
    List<Map<String, dynamic>> yuri = await db.rawQuery('SELECT COUNT (*) FROM $TABELA');
    int resultado = firstIntValue(yuri);//primeiro valor do map 
    return resultado;//retornando o id do contato
  }

  Future close() async{
    Database db = await this.dataBase;  
    db.close();
    
  }





}