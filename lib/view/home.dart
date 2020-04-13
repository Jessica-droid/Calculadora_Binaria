import 'package:binariocalc/control/HomeControl.dart';
import 'package:binariocalc/view/bloco_entrada.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  int _radioValue = 0;
  TextEditingController _primeiroValor = TextEditingController();
  TextEditingController _segundoValor = TextEditingController();

  HomeControl homeControl;

  @override
  void initState() {
    homeControl = HomeControl(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          title: Text(
        "BinCalc",
        style: TextStyle(color: Colors.white),
      )),
      body: SafeArea(
        child: SingleChildScrollView(child: _content()),
      ),
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Campos de entrada
            BlocoEntradaValores(
                campoHint: "Primeiro valor", entradaControler: _primeiroValor),

            SizedBox(height: 8),

            BlocoEntradaValores(
                campoHint: "Segundo Valor", entradaControler: _segundoValor),

            SizedBox(height: 8),

            //Definir operação
            _selecionarOperacao(),

            SizedBox(height: 8),

            //Calcular
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                color: Colors.green[200],
                child: Text(
                  "CALCULAR",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => homeControl.validarCalcular(
                    _formKey,
                    _radioValue,
                    _primeiroValor.text.toString(),
                    _segundoValor.text.toString())),

            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  Widget _selecionarOperacao() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: _blocoOperacoes(),
    );
  }

  Widget _blocoOperacoes() {
    return Column(
      children: <Widget>[
        Text(
          "Selecione a operação a ser realizada:",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        _operaceos()
      ],
    );
  }

  Widget _operaceos() {
    return Wrap(
      direction: Axis.horizontal,
      children: <Widget>[
        //Soma
        _operao("Soma", 0, _radioValue),

        _operao("Subtração", 1, _radioValue),

        _operao("Multiplicação", 2, _radioValue),

        _operao("Divisão", 3, _radioValue),

        _operao("Retornar Resto", 4, _radioValue),
      ],
    );
  }

  Widget _operao(String operacao, int radioValue, int radioGroup) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio(
          value: radioValue,
          groupValue: radioGroup,
          onChanged: _valorAlterado,
        ),

        //Descricao
        Text(operacao),

        SizedBox(width: 16)
      ],
    );
  }

  void _valorAlterado(int valor) {
    setState(() {
      _radioValue = valor;
    });
  }
}
