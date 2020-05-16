import 'package:cadastro_cidades_covid/routes/rotas_app.dart';
import 'package:cadastro_cidades_covid/view/cidade_form.dart';
import 'package:cadastro_cidades_covid/view/lista_cidade.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListaCidades(),
      routes: {
        AppRotas.CIDADE_FORM: (_) => CidadeForm()
      },
    );
  }
}

