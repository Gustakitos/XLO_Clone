import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helper/extensions.dart';
import 'package:xlo_mobx/screens/ad/ad_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.ad, this.store);

  final Ad ad;
  final MyAdsStore store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Já vendi', iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: ad.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : ad.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '${ad.views} visitas',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<MenuChoice>(
                  onSelected: (choice) {
                    switch (choice.index) {
                      case 0:
                        editAd(context);
                        break;
                      case 1:
                        soldAd(context);
                        break;
                      case 2:
                        deleteAd(context);
                        break;
                      default:
                        break;
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.purple,
                  ),
                  itemBuilder: (_) {
                    return choices
                        .map(
                          (e) => PopupMenuItem<MenuChoice>(
                            value: e,
                            child: Row(
                              children: [
                                Icon(
                                  e.iconData,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  e.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CreateScreen(ad: ad)));

    if (success != null && success) store.refresh();
  }

  void soldAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Vendido'),
        content: Text('Confirmar a venda de ${ad.title}?'),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldAd(ad);
            },
            child: Text('Sim'),
            textColor: Colors.red,
          )
        ],
      ),
    );
  }

  void deleteAd(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir'),
        content: Text('Confirmar a exclusão de ${ad.title}?'),
        actions: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Não'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: Text('Sim'),
            textColor: Colors.red,
          )
        ],
      ),
    );
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
