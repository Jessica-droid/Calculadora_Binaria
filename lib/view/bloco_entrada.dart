import 'package:flutter/material.dart';

class BlocoEntradaValores extends StatefulWidget {
  BlocoEntradaValores(
      {@required this.campoHint, @required this.entradaControler});

  final String campoHint;
  final TextEditingController entradaControler;

  @override
  _BlocoEntradaValoresState createState() => _BlocoEntradaValoresState();
}

class _BlocoEntradaValoresState extends State<BlocoEntradaValores> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Valor
          TextFormField(
            controller: widget.entradaControler,
            enabled: false,
            maxLength: 9,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.grey[600]),
                errorStyle: TextStyle(color: Colors.red),
                hintText: widget.campoHint,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 1,
                        style: BorderStyle.solid))),
            validator: (valor) {
              if (valor.isEmpty) {
                return "Preencha este campo.";
              } else
                return null;
            },
          ),

          SizedBox(height: 16),

          _teclado(),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _teclado() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //0
        RaisedButton(
            color: Colors.green[200],
            padding: EdgeInsets.only(top: 8, bottom: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child:
                Text("0", style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              //O numero binario deve ter no máxiomo 9 dígitos
              if (widget.entradaControler.text.length < 9) {
                widget.entradaControler.text =
                    "${widget.entradaControler.text.toString()}0";
              }
            }),

        SizedBox(width: 16),

        //1
        RaisedButton(
            color: Colors.green[200],
            padding: EdgeInsets.only(top: 8, bottom: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child:
                Text("1", style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              //O numero binario deve ter no máxiomo 9 dígitos
              if (widget.entradaControler.text.length < 9) {
                widget.entradaControler.text =
                    "${widget.entradaControler.text.toString()}1";
              }
            }),

        SizedBox(width: 16),

        //Limpar
        RaisedButton(
          color: Colors.green[200],
          padding: EdgeInsets.only(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Text("LIMPAR",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () => widget.entradaControler.text = "",
        )
      ],
    );
  }
}
