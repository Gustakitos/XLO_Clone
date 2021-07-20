import 'package:mobx/mobx.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  _ConnectivityStoreBase() {
    _setupListener();
  }

  void _setupListener() {
    DataConnectionChecker().checkInterval = Duration(seconds: 3);
    DataConnectionChecker().onStatusChange.listen((event) {
      setConnected(event == DataConnectionStatus.connected);
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
