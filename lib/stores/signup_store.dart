import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helper/extensions.dart';

part 'signup_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError {
    if (name == null || nameValid)
      return null;
    else if (name.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Nome muito curto';
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid)
      return null;
    else if (email.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Email inválido';
  }

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (email == null || phoneValid)
      return null;
    else if (phone.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Telefone inválido';
  }
}
