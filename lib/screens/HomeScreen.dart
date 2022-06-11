import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salvadanaio/widgets/CreaTransazioneButton.dart';
import 'package:salvadanaio/widgets/VediListaTransazioniButton.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a todo'),
      ),
      body: Column(
        children: <Widget>[
          Center(child: CreaTransazioneButton()),
          Center(child: VediListaTransazioniButton())
        ],
      ),
    );
  }
}