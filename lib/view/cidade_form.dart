import 'package:cadastro_cidades_covid/banco/db_helper.dart';
import 'package:cadastro_cidades_covid/model/cidade.dart';
import 'package:flutter/material.dart';

class CidadeForm extends StatefulWidget {
  @override
  _CidadeFormState createState() => _CidadeFormState();
}

DBHelper db = DBHelper();//instancia do banco
final _formulario = GlobalKey<FormState>(); //global key referente a key do meu formulario para poder acessar os values digitados
final Map<String, Object> _formularioValores = {}; //map object pois posso ter string int e tals
int retorno;

void _carregaFormulario(Cidade cidadeSelecionada){
  _formularioValores['id'] = cidadeSelecionada.id;
  _formularioValores['nome_cidade'] = cidadeSelecionada.nomeCidade;
  _formularioValores['desc_quarentena'] = cidadeSelecionada.descriQuarentena;
  _formularioValores['infectados'] = cidadeSelecionada.infectados.toString();
  _formularioValores['recuperados'] = cidadeSelecionada.recuperados.toString();
}

void _limpaFormulario(){//GAMBIARRA
  _formularioValores['id'] = null;
  _formularioValores['nome_cidade'] = null;
  _formularioValores['desc_quarentena'] = null;
  _formularioValores['infectados'] = null;
  _formularioValores['recuperados'] = null;
}


class _CidadeFormState extends State<CidadeForm> {
  @override
  Widget build(BuildContext context) {
    bool editando = false;
    Cidade cidadeSelecionada = ModalRoute.of(context).settings.arguments;//pegando argumento da lista que foi passado usado metodo para editar

    if (cidadeSelecionada !=null){
      _carregaFormulario(cidadeSelecionada);
      editando = true;
    }else{
      //TODO: nao tive tempo de tentar trocar minha classe para stateless, troquei começou quebrar umas coisas ai deixei quieto
      _limpaFormulario();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('formulario cidade'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              //agora posso acessar meu formulario com onPressed
              bool valida = _formulario.currentState.validate();

              if (valida){
                _formulario.currentState.save(); //metodo que posso chamar dentro de cada um dos filds
                Cidade cidade = Cidade (
                  //nao passo o id pois é auto increment, no caso de um cadastro
                   nomeCidade: _formularioValores['nome_cidade'],
                   descriQuarentena: _formularioValores['desc_quarentena'],
                   infectados: _formularioValores['infectados'],
                   recuperados: _formularioValores['recuperados']
                );

                if (editando == false){
                  db.insereCidade(cidade); //insere a cidade na lista
                }else{
                  //formulario valores esta o valor da cidade clicada entao aqui eu coloco esse id, um pouco gambiarra
                  cidade.id = _formularioValores['id'];
                  db.alteraCidade(cidade); //altera cidade
                }
                Navigator.of(context).pop("retorno");//retira a pagina da pilha
              }              
            }
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(20),
        child: Form( //no formulario tera todos os campos de entrada dentro de uma coluna pra ficar mais certinho, alinhado
           key: _formulario,//key usada para o global formulario
           child: Column(
             children: <Widget>[//array de widget
               TextFormField(
                 initialValue: _formularioValores['nome_cidade'], //se editando for true, esses valores vao ser adicionados e em initValue tera o valor do cidade selecionada 
                 decoration: InputDecoration(labelText: 'Nome Cidade'), //lbl placeholder
                 validator: (value){
                    if (value == null || value.trim().isEmpty)
                      return 'Pô! nome da cidade vazio irmão!';

                    if(value.trim().length <= 2)
                      return 'cidade com esse nome?????';

                    return null;//se tudo der certo
                 },
                 onSaved: (value)=>_formularioValores['nome_cidade'] = value, 
               ),
               TextFormField(
                 initialValue: _formularioValores['desc_quarentena'],
                 decoration: InputDecoration(labelText: 'Descricao Quarentena'),
                 validator: (value){
                   if (value == null || value.trim().isEmpty)
                      return 'Por favor insira uma descricao';

                    return null;//se tudo der certo
                 },
                 onSaved: (value)=>_formularioValores['desc_quarentena'] = value,
               ),
               TextFormField(
                 initialValue: _formularioValores['infectados'],
                 decoration: InputDecoration(labelText: 'Numero infectados'),
                 validator: (value){
                   if (value == null || value.trim().isEmpty)
                      return 'Por favor insira numeros infectados';

                  //verificando se foi digitado numeros
                   try{
                      int.parse(value);
                    }catch(erro){
                      return 'Digite numeros';
                    }
                    return null;  
                 },
                 onSaved: (value)=>_formularioValores['infectados'] = int.parse(value),
               ),
               TextFormField(
                 initialValue: _formularioValores['recuperados'],
                 decoration: InputDecoration(labelText: 'Numero recuperados'),
                  validator: (value){
                   if (value == null || value.trim().isEmpty)
                      return 'Por favor insira numeros recuperados';
                    
                    try{
                      int.parse(value);
                    }catch(erro){
                      return 'Digite numeros';
                    }

                    return null;
                 },
                 onSaved: (value)=>_formularioValores['recuperados'] = int.parse(value),
               ),
             ],

           ),
        ),
      ),      
    );
  }
}