import 'package:flutter/material.dart';

class DlgResultado extends StatelessWidget {
  DlgResultado({@required this.resultado});

  final String resultado;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text("O resultado é:", style: TextStyle(color: Colors.grey[600])),
      content: Text(
        resultado,
        style: TextStyle(color: Colors.green[400], fontSize: 24),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "OK",
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
