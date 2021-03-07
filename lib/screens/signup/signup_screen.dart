import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                    FieldTitle(
                      title: 'Apelido',
                      subTitle: 'Como aparecerá em seus anuncios',
                    ),
                    Observer(builder: (_) {
                      return TextField(
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
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Confirmar Senha',
                      subTitle: 'Repita a Senha',
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      obscureText: true,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 12),
                      height: 40,
                      child: RaisedButton(
                        color: Colors.orange,
                        child: Text('Criar Conta'),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {},
                      ),
                    ),
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
