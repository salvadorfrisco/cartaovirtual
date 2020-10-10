import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:virtual_card/models/card_info.dart';
import 'package:virtual_card/services/storage_service.dart';

class ColorsBloc extends BlocBase {
  StorageService storage = StorageService();

  final _colorsController = BehaviorSubject<CardInfo>();
  Stream<CardInfo> get colorsStream => _colorsController.stream;
  Sink<CardInfo> get colorsSink => _colorsController.sink;

  updateOpacity(cardInfo) {
    storage.saveData(cardInfo, false);
    colorsSink.add(cardInfo);
  }

  @override
  void dispose() {
    _colorsController.close();
    super.dispose();
  }
}

