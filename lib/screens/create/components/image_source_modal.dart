import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(onPressed: () {}, child: Text('Camera')),
            FlatButton(onPressed: () {}, child: Text('Galeria')),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecionar foto para o anuncio'),
        message: Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CupertinoActionSheetAction(onPressed: () {}, child: Text('Camera')),
          Divider(),
          CupertinoActionSheetAction(onPressed: () {}, child: Text('Galeria')),
        ],
      );
  }
}
