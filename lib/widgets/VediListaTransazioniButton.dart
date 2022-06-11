import 'package:flutter/material.dart';
import 'package:salvadanaio/screens/ListaTransazioni.dart';


class VediListaTransazioniButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateToReadTodoScreen(context);
        print("Leggi....");
      },
      child: Text("Read Todo"),
    );
  }

  _navigateToReadTodoScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadTodoScreen()),
    );
  }
}