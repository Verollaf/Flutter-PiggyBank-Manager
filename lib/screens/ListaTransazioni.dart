
import 'package:flutter/material.dart';
import 'package:salvadanaio/model/Transazione.dart';
import 'package:salvadanaio/screens/DettagliTransazione.dart';
import '../helper/DatabaseHelper.dart';

class  ReadTodoScreen extends StatefulWidget {
  @override
  _ReadTodoScreenState createState() => _ReadTodoScreenState();
}

class _ReadTodoScreenState extends State<ReadTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La lista delle vecchie transazioni'),
      ),
      body: FutureBuilder<List<Transazione>>(
        future: DatabaseHelper.instance.retriveTransazioni(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].totale.toString()),
                  leading: Text(snapshot.data[index].id.toString()),
                  subtitle: Text(snapshot.data[index].desrizione),
                  onTap: () => _navigateToDetail(context, snapshot.data[index]),
                  trailing: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        _deleteTodo(snapshot.data[index]);
                        setState(() {});
                      }),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Oops!");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_deleteTodo(Transazione transazione) {
  DatabaseHelper.instance.deleteTransazione(transazione.id);
}

_navigateToDetail(BuildContext context, Transazione transazione) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DettagliTransazione(transazione: transazione)),
  );
}

