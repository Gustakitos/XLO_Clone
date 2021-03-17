import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  ImageSourceModal(this.onImageSelected);

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(onPressed: getFromCamera, child: Text('Camera')),
            FlatButton(onPressed: getFromGallery, child: Text('Galeria')),
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
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: Text('Camera'),
          ),
          Divider(),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: Text('Galeria'),
          ),
        ],
      );
  }

  Future<void> getFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    final image = File(pickedFile.path);
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    print(image.path);
    final croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Image',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Image',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );

    if (croppedImage != null) onImageSelected(croppedImage);
  }
}
