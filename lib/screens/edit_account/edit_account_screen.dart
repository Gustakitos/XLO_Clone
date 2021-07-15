import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

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
                  Observer(builder: (_) {
                    return IgnorePointer(
                      ignoring: store.loading,
                      child: LayoutBuilder(
                        builder: (_, BoxConstraints constraints) {
                          return ToggleSwitch(
                            minWidth: (constraints.maxWidth.toInt() + 1) / 2,
                            labels: ['Particular', 'Profissional'],
                            cornerRadius: 20,
                            totalSwitches: 2,
                            activeBgColor: [Colors.purple],
                            inactiveBgColor: Colors.grey,
                            activeFgColor: Colors.white,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: store.userType.index,
                            onToggle: store.setUserType,
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: store.name,
                      enabled: !store.loading,
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
                      initialValue: store.phone,
                      onChanged: store.setPhone,
                      enabled: !store.loading,
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
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: store.setPassword,
                      enabled: !store.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova Senha',
                      ),
                    );
                  }),
                  SizedBox(
                    height: 8,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      onChanged: store.setPasswordConfirmation,
                      enabled: !store.loading,
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
                        disabledColor: Colors.orange.withAlpha(100),
                        elevation: 0,
                        textColor: Colors.white,
                        child: store.loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              )
                            : Text('Salvar'),
                        onPressed: store.savePressed,
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
                      child: Text('Log Out'),
                      onPressed: () {
                        store.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pop();
                      },
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
