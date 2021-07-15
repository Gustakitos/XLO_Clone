import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  _EditAccountStore() {
    user = userManagerStore.user;

    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  User user;

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

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;

    user.name = name;
    user.phone = phone;
    user.type = userType;

    if (password.isNotEmpty)
      user.password = password;
    else
      user.password = null;

    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  void logout() => userManagerStore.logout();
}
