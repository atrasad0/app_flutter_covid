import 'package:flutter/cupertino.dart';

class Cidade{
  //atributos da classe cidade
  int id;
  String nomeCidade;
  String descriQuarentena;
  int infectados;
  int recuperados;

  //construtor da classe cidade
  Cidade({
    this.id,
    @required this.nomeCidade, //@required atributo obrigatorio
    @required this.descriQuarentena, 
    @required this.infectados, 
    @required this.recuperados,  
  });

  //Converte para objeto para map
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'nome_cidade': nomeCidade,
      'desc_quarentena': descriQuarentena,
      'infectados': infectados,
      'recuperados': recuperados
    };
    return map;
  }

  Cidade.fromMap(Map<String, dynamic> map){
    id = map['id'];
    nomeCidade = map['nome_cidade'];
    descriQuarentena = map['desc_quarentena'];
    infectados = map['infectados'];
    recuperados = map['recuperados'];
  }

}