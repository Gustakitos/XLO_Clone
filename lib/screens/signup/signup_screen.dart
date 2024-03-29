import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpStore signUpStore = SignUpStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ErrorBox(
                          message: signUpStore.error,
                        ),
                      );
                    }),
                    FieldTitle(
                      title: 'Apelido',
                      subTitle: 'Como aparecerá em seus anuncios',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: João S.',
                          isDense: true,
                          errorText: signUpStore.nameError,
                        ),
                        onChanged: signUpStore.setName,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'E-mail',
                      subTitle: 'Enviaremos um e-mail de confirmação',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: joao@gmail.com',
                          isDense: true,
                          errorText: signUpStore.emailError,
                        ),
                        onChanged: signUpStore.setEmail,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Celular',
                      subTitle: 'Proteja sua conta',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '(99) 99999-99',
                          isDense: true,
                          errorText: signUpStore.phoneError,
                        ),
                        onChanged: signUpStore.setPhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Senha',
                      subTitle:
                          'Use letras, números e caracteres especiais. Minimo: 8',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.pass1Error,
                        ),
                        obscureText: true,
                        onChanged: signUpStore.setPass1,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Confirmar Senha',
                      subTitle: 'Repita a Senha',
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          errorText: signUpStore.pass2Error,
                        ),
                        obscureText: true,
                        onChanged: signUpStore.setPass2,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        margin: EdgeInsets.only(top: 20, bottom: 12),
                        height: 40,
                        child: RaisedButton(
                          color: Colors.orange,
                          disabledColor: Colors.orange.withAlpha(120),
                          child: signUpStore.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text('Criar Conta'),
                          textColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: signUpStore.signUpPressed,
                        ),
                      );
                    }),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Já tem uma conta? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.purple,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
