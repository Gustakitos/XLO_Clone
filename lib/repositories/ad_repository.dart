import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AdRepository {
  Future<List<Ad>> getHomeAdList({
    FilterStore filter,
    String search,
    Category category,
    int page,
  }) async {
    try {
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

      queryBuilder.includeObject([keyAdOwner, keyAdCategory]);

      queryBuilder.setAmountToSkip(page * 20);
      queryBuilder.setLimit(20);

      queryBuilder.whereEqualTo(keyAdStatus, AdStatus.ACTIVE.index);

      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
      }

      if (category != null && category.id != '*') {
        queryBuilder.whereEqualTo(
            keyAdCategory,
            (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
                .toPointer());
      }

      switch (filter.orderBy) {
        case OrderBy.PRICE:
          queryBuilder.orderByAscending(keyAdPrice);
          break;
        case OrderBy.DATE:
        default:
          queryBuilder.orderByDescending(keyAdCreatedAt);
          break;
      }

      if (filter.minPrice != null && filter.minPrice > 0) {
        queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filter.minPrice);
      }

      if (filter.maxPrice != null && filter.maxPrice > 0) {
        queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filter.maxPrice);
      }

      if (filter.vendorType != null &&
          filter.vendorType > 0 &&
          filter.vendorType <
              (VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR)) {
        final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

        if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
          userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
        }

        if (filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
          userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
        }

        queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
      }

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results.map((e) => Ad.fromParse(e)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha de Conexão');
    }
  }

  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);

      final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user.id);

      final adObject = ParseObject(keyAdTable);

      if (ad.id != null) adObject.objectId = ad.id;

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(keyAdTitle, ad.title);
      adObject.set<String>(keyAdDescription, ad.description);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      adObject.set<num>(keyAdPrice, ad.price);
      adObject.set<int>(keyAdStatus, ad.status.index);

      adObject.set<String>(keyAdDistrict, ad.address.district);
      adObject.set<String>(keyAdCity, ad.address.city.name);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);

      adObject.set<List<ParseFile>>(keyAdImages, parseImages);

      adObject.set<ParseUser>(keyAdOwner, parseUser);

      adObject.set<ParseObject>(keyAdCategory,
          ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));

      final response = await adObject.save();

      if (!response.success)
        return Future.error(ParseErrors.getDescription(response.error.code));
    } catch (e) {
      return Future.error('Falha ao salvar o anuncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();

          if (!response.success)
            return Future.error(
                ParseErrors.getDescription(response.error.code));

          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;

          parseImages.add(parseFile);
        }
      }
    } catch (e) {
      return Future.error('Erro ao salvar imagem');
    }

    return parseImages;
  }

  Future<List<Ad>> getMyAds(User user) async {
    final currentUser = ParseUser('', '', '')..set(keyUserId, user.id);
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAdCreatedAt);
    queryBuilder.whereEqualTo(keyAdOwner, currentUser.toPointer());
    queryBuilder.includeObject([keyAdCategory, keyAdOwner]);

    final response = await queryBuilder.query();
    if (response.success && response.results != null)
      return response.results.map((e) => Ad.fromParse(e)).toList();
    else if (response.success && response.results == null)
      return [];
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<void> sold(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)..set(keyAdId, ad.id);

    parseObject.set(keyAdStatus, AdStatus.SOLD.index);

    final response = await parseObject.save();
    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<void> delete(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)..set(keyAdId, ad.id);

    parseObject.set(keyAdStatus, AdStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }
}
