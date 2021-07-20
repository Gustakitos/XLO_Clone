import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/favorite_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ObservableList<Ad> favoriteList = ObservableList<Ad>();

  _FavoriteStoreBase() {
    reaction((_) => userManagerStore.isLoggedIn, (_) {
      _getFavoriteList();
    });
  }

  @action
  Future<void> _getFavoriteList() async {
    try {
      favoriteList.clear();
      final favorites =
          await FavoriteRepository().getFavorites(userManagerStore.user);
      favoriteList.addAll(favorites);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> toggleFavorite(Ad ad) async {
    try {
      if (favoriteList.any((element) => element.id == ad.id)) {
        favoriteList.removeWhere((element) => element.id == ad.id);
        await FavoriteRepository().delete(ad: ad, user: userManagerStore.user);
      } else {
        favoriteList.add(ad);
        await FavoriteRepository().save(ad: ad, user: userManagerStore.user);
      }
    } catch (e) {
      print(e);
    }
  }
}
