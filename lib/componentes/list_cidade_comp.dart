import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:flutter/material.dart';

class ListCidadeComp extends StatelessWidget {

   List<Cidade> listaCidades = List<Cidade>();
   int index;

  ListCidadeComp(this.listaCidades,this.index);//construtor recebendo o tipo cidade

  @override
  Widget build(BuildContext context) {
    final avatarCidade = CircleAvatar(child: Icon(Icons.account_balance));
    var nome = listaCidades[index].nomeCidade;
    return ListTile(
      leading: avatarCidade,
      title: Text(listaCidades[index].nomeCidade),//usando atributos de cidade
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
  }
}