import 'package:cadastro_cidades_covid/model/cidade.dart';

//mapping de cidades
var CidadeTeste = { //conjunto de chave e valor do tipo cidade
  '1' :  Cidade(
    id: 1,
    nomeCidade: 'Sao Carlos',
    descriQuarentena: 'Ninguem ta nem ae, todos na rua',
    infectados: 40,
    recuperados: 25

  ),
   '2' :  Cidade(
  id: 2,
  nomeCidade: 'Araraquara',
  descriQuarentena: 'Pessoal em choque',
  infectados: 100,
  recuperados: 40
  )
};