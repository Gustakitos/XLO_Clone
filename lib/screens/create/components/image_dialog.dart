import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({@required this.image, @required this.onDelete});

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(
            image,
            fit: BoxFit.contain,
            width: 600,
            height: 400,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            child: Text('Excluir'),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
