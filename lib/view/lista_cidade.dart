import 'package:cadastro_cidades_covid/banco/db_helper.dart';
import 'package:cadastro_cidades_covid/componentes/list_cidade_comp.dart';
import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:flutter/material.dart';

class ListaCidades extends StatefulWidget {
  @override
  _ListaCidadesState createState() => _ListaCidadesState();
}

class _ListaCidadesState extends State<ListaCidades> {
 
  DBHelper db = DBHelper();
  List<Cidade> listaCidades = List<Cidade>();

  //espera o componente carregar para fazer esse metodo
  @override
  void initState(){
    super.initState();
    db.pegaTodasCidades().then((lista){
      setState(() {//atualiza interface com os dados do BD
        listaCidades = lista;
      });
    });
  } 
  

 @override
  Widget build(BuildContext context) {
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
        /*itemBuilder: (contexto, index){
          return _listaCidades(contexto,index);
        },*/
        ),  
    );
  }

  /*_listaCidades(BuildContext contexto, int index){
    final avatarCidade = CircleAvatar(child: Icon(Icons.account_balance));
    return ListTile(
      leading: avatarCidade,
      title: Text(listaCidades[index].nomeCidade),//usando atributo nome da lista de cidade
      subtitle: Text(listaCidades[index].descriQuarentena),
      trailing: Container(
        width:100,
        child: Row(// icone para editar e excluir
          children: <Widget>[
            IconButton(//editar
            icon: Icon(Icons.edit),
            color: Colors.blue,
            onPressed: (){},
          ),
          IconButton(//excluir
            icon: Icon(Icons.delete_forever),
            color: Colors.red,
            onPressed: (){},
          )
        ],
        ),
      ),
    );
  }*/
}