import 'package:flutter/material.dart';
import 'package:salvadanaio/model/Transazione.dart';
import '../helper/DatabaseHelper.dart';

class DettagliTransazione extends StatefulWidget {
  static const routeName = '/detailTodoScreen';
  final Transazione transazione;

  const DettagliTransazione({Key key, this.transazione}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _CreateTransazioneState(transazione);
}

class _CreateTransazioneState extends State<DettagliTransazione> {
  Transazione transazione;
  final descriptionTextController = TextEditingController();
  final totaleTextController = TextEditingController();
  _CreateTransazioneState(this.transazione);
  String title;
  @override
  void initState() {
    super.initState();
    if (transazione != null) {
      title = "Modifica transazione #" + transazione.id.toString();
      descriptionTextController.text = transazione.desrizione;
    } else {
      title = "Nuova transazione";
    }
  }

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              maxLines: 10,
              controller: descriptionTextController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Totale"),
              maxLines: 1,
              controller: totaleTextController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () async {
            _saveTodo(totaleTextController.text, descriptionTextController.text);
            setState(() {});
          }),
    );
  }

  _saveTodo(String totale, String descrizione) async {
    if (transazione == null) {
      DatabaseHelper.instance.insertTransazione(
          Transazione(
            dateTime: DateTime.now().toString(),
            totale: double.parse(totaleTextController.text),
            desrizione: descriptionTextController.text)
      );
      Navigator.pop(context, "Your todo has been saved.");
    } else {
      await DatabaseHelper.instance
          .updateTransazione(Transazione(id: transazione.id, dateTime: transazione.dateTime, desrizione: transazione.desrizione + "\n Modificata il " + DateTime.now().toString(), totale: transazione.totale));
      Navigator.pop(context);
    }
  }
}
