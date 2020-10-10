import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:virtual_card/models/card_info.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/photo_helper.dart';

class ThemeBloc extends BlocBase {
  StorageService storage = StorageService();

  final _themeController = BehaviorSubject<dynamic>();
  Stream<dynamic> get themeStream => _themeController.stream;
  Sink<dynamic> get themeSink => _themeController.sink;

  saveTheme(img64, version) {
    PhotoHelper.savePhotoLocal64(img64, 'imageBackground', version);
    themeSink.add(img64);
  }

  @override
  void dispose() {
    _themeController.close();
    super.dispose();
  }
}

