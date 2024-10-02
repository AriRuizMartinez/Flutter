import 'package:flutter/cupertino.dart';
import '../models/activitat.dart';

class ActivitatsProvider extends ChangeNotifier {
  List<Activitat> _activitats = [];

  List<Activitat> get activitats => _activitats;

  void afegirActivitat(Activitat novaActivitat) {
    _activitats.add(novaActivitat);
    notifyListeners();
  }
}