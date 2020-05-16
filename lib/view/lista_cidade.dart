import 'package:cadastro_cidades_covid/banco/cidades_teste.dart';
import 'package:cadastro_cidades_covid/banco/db_helper.dart';
import 'package:cadastro_cidades_covid/componentes/list_cidade_comp.dart';
import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:flutter/material.dart';

class ListaCidades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  //final cidade = {...CidadeTeste};//spread copia do array
  DBHelper db = DBHelper();
  List<Cidade> listaCidades = List<Cidade>();

  //Cidade c = Cidade(nomeCidade: 'Sao Carlos', descriQuarentena: 'teste', infectados: 5, recuperados: 5);
  //db.insereCidade(c);
  
  db.pegaTodasCidades().then((lista){
    print(lista);
    listaCidades = lista;
  });


    return Scaffold(//Tela
      appBar: AppBar(
        title: Text("Cidades COVID 19"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            color: Colors.green,
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listaCidades.length,
        itemBuilder: (cotexto, index) =>ListCidadeComp(listaCidades,index),
        ),  
    );
  }
}