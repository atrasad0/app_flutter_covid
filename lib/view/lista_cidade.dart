import 'package:cadastro_cidades_covid/banco/db_helper.dart';
import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:cadastro_cidades_covid/routes/rotas_app.dart';
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
    atualizaLista();//reciclagem de codigo
    _adicionaCidadeTeste(); //adiciona uma cidade para teste para poder ja visualizar layout e tals
  } 

void atualizaLista(){
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
            color: Colors.black,
            onPressed: () {
                _insereCidade();
                
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listaCidades.length,
        //itemBuilder: (cotexto, index) =>ListCidadeComp(listaCidades,index),
        itemBuilder: (contexto, index){
          return _listaCidades(contexto,index);
        },
        ),  
    );
  }

  _listaCidades(BuildContext contexto, int index){
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
            onPressed: (){
              _editaCidade(index);
            },
          ),
          IconButton(//excluir
            icon: Icon(Icons.delete_forever),
            color: Colors.red,
            onPressed: (){
              showDialog(
                context: contexto,
                builder: (contexto) => AlertDialog( //apartir do contexto o builder cria algo que eu quero, no caso uma mensagem
                  title: Text('Deseja excluir essa cidade?'),
                  actions: <Widget>[
                    FlatButton(onPressed: (){
                      Navigator.of(contexto).pop();
                    }, //funcao vazia para nao fazer nada apnesa fechando o modalzinho
                      child: Text('NÃO!'),
                      ),
                      FlatButton(onPressed: (){
                        _excluiCidade(listaCidades[index].id,index);
                         Navigator.of(contexto).pop();
                      },
                      child: Text('Sim'),
                      ),
                  ],
                ),
              );
            },
          )
        ],
        ),
      ),
    );
  }

  //metodo que verifica o retorno de uma incersao e atualiza o estado da lista
  void _insereCidade() async{
    final retornoRecebido = await Navigator.of(context).pushNamed(//coloca uma tela em cima da outra
      AppRotas.CIDADE_FORM);
    if (retornoRecebido != null){
      atualizaLista();
    }

  }

  void _editaCidade(index) async{
    final retornoRecebido = await Navigator.of(context).pushNamed(
      AppRotas.CIDADE_FORM,
      arguments: listaCidades[index]
    );
    if (retornoRecebido != null){
      atualizaLista();
    }
  }

  void _excluiCidade(idCidadeBanco,indexLista)async{//o id da cidade é diferente do id cidade banco
    if (indexLista != null){
      setState(() {
        listaCidades.removeAt(indexLista);
        db.excluiCidade(idCidadeBanco);
       
      });
      
    }
  }

 
 void _adicionaCidadeTeste(){   

      if (listaCidades.length == 0){
        Cidade c = Cidade(nomeCidade: 'São Carlos', descriQuarentena: 'Quarentena começou em 20/03/2020', infectados: 38, recuperados: 30);
        db.insereCidade(c);
        atualizaLista();
      }
    }

}