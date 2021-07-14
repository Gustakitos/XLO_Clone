import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (_, BoxConstraints constraints) {
                      print(constraints.biggest.width);
                      print(constraints.maxWidth);
                      return ToggleSwitch(
                        minWidth: (constraints.maxWidth.toInt() + 1) / 2,
                        labels: ['Particular', 'Profissional'],
                        cornerRadius: 20,
                        totalSwitches: 2,
                        activeBgColor: [Colors.purple],
                        inactiveBgColor: Colors.grey,
                        activeFgColor: Colors.white,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: 0,
                        onToggle: store.setUserType,
                      );
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome*',
                        errorText: store.nameError,
                      ),
                      onChanged: store.setName,
                    );
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: store.setPhone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Telefone*',
                        errorText: store.phoneError,
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    onChanged: store.setPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Nova Senha',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: store.setPasswordConfirmation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirmação de Senha',
                        errorText: store.passConfirmError,
                      ),
                    );
                  }),
                  SizedBox(
                    height: 12,
                  ),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 40,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.orange,
                        elevation: 0,
                        textColor: Colors.white,
                        child: Text('Salvar'),
                        onPressed: store.isFormValid ? () {} : null,
                      ),
                    );
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      child: Text('Sair'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
