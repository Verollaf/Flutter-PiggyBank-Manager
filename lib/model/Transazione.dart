class Transazione {
  final int id;
  final double totale;
  final String desrizione;
  final String dateTime;
  static const String TABLENAME = "transazioni";

  Transazione({this.id, this.totale, this.desrizione, this.dateTime});

  Map<String, dynamic> toMap() {
    return {'id': id, 'descrizione': desrizione, 'totale': totale, 'data': dateTime};
  }
}
