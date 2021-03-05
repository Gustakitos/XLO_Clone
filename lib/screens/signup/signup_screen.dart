import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldTitle(
                title: 'Apelido',
                subTitle: 'Como aparecerá em seus anuncios',
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Exemplo: João S.',
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FieldTitle(
                title: 'E-mail',
                subTitle: 'Enviaremos um e-mail de confirmação',
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Exemplo: joao@gmail.com',
                  isDense: true,
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              SizedBox(
                height: 16,
              ),
              FieldTitle(
                title: 'Celular',
                subTitle: 'Proteja sua conta',
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Exemplo: João S.',
                  isDense: true,
                ),
              ),
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
                  hintText: 'Exemplo: João S.',
                  isDense: true,
                ),
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
                  hintText: 'Exemplo: João S.',
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
