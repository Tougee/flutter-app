import 'package:flutter_app/asset_item.dart';
import 'package:flutter_app/dao/base_dao.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/asset.dart';

const PREFIX_ASSET_ITEM = "SELECT a1.asset_id AS assetId, a1.symbol, a1.name, a1.icon_url AS iconUrl, " +
            "a1.balance, a1.public_key AS publicKey, a1.price_btc AS priceBtc, a1.price_usd AS priceUsd, " +
            "a1.chain_id AS chainId, a1.change_usd AS changeUsd, a1.change_btc AS changeBtc, a1.hidden, " +
            "a1.confirmations, a2.icon_url AS chainIconUrl, a2.symbol as chainSymbol, " +
            "a1.account_name AS accountName, a1.account_tag AS accountTag " +
            "FROM assets a1 " +
            "LEFT JOIN assets a2 ON a1.chain_id = a2.asset_id ";
const POSTFIX = " ORDER BY balance * price_usd DESC, price_usd DESC, cast(balance AS REAL) DESC, name DESC";
const POSTFIX_ASSET_ITEM = " ORDER BY a1.balance * a1.price_usd DESC, a1.price_usd DESC, cast(a1.balance AS REAL) DESC, a1.name DESC";
const POSTFIX_ASSET_ITEM_NOT_HIDDEN = " WHERE a1.hidden ISNULL OR NOT a1.hidden$POSTFIX_ASSET_ITEM";

const String TABLE_NAME = "assets";

class AssetDao extends BaseDao<Asset> {
  AssetDao(DBProvider db) : super(db);

  @override
  void delete(t) async {
    var database = await db.instance;
    database.delete(TABLE_NAME, where: "id = ?", whereArgs: [t.assetId]);
  }

  @override
  void deleteList(List list) {
  }

  @override
  void insert(t) async {
    var database = await db.instance;
    database.insert(TABLE_NAME, t.toJson());
  }

  @override
  void insertList(List list) {
  }

  @override
  void update(t) {
  }

  Future<List<AssetItem>> assetItemsNotHidden() async {
    final database = await db.instance;
    var res = await database.rawQuery(PREFIX_ASSET_ITEM + POSTFIX_ASSET_ITEM_NOT_HIDDEN);
    List<AssetItem> list = res.isNotEmpty
        ? res.map((c) => AssetItem.fromJson(c)).toList() : [];
    return list;
  }

}