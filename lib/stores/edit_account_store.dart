import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  @observable
  UserType userType;

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError =>
      nameValid || name == null ? null : 'Campo Obrigatorio';

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError =>
      phoneValid || phone == null ? null : 'Campo Obrigatorio';

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  String passwordConfirmation = '';

  @computed
  bool get passConfirmValid =>
      password == passwordConfirmation &&
      (password.length >= 6 || password.isEmpty);
  String get passConfirmError {
    if (password.isNotEmpty && password.length < 6)
      return 'Senha muito curta';
    else if (password != passwordConfirmation) return 'Senhas não coincidem';
    return null;
  }

  @action
  void setPasswordConfirmation(String value) => passwordConfirmation = value;

  @computed
  bool get isFormValid => nameValid && phoneValid && passConfirmValid;
}
