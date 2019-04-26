import 'dart:convert';
import 'package:decimal/decimal.dart';

AssetItem assetFromJson(String str) {
  final jsonData = json.decode(str);
  return AssetItem.fromJson(jsonData);
}

String assetToJson(AssetItem asset) {
  final dyn = asset.toJson();
  return json.encode(dyn);
}

class AssetItem {
  String assetId;
  String symbol;
  String name;
  String iconUrl;
  String balance;
  String publicKey;
  String priceBtc;
  String priceUsd;
  String chainId;
  String changeUsd;
  String changeBtc;
  int hidden;
  int confirmations;
  String chainIconUrl;
  String chainSymbol;
  String accountName;
  String accountTag;

  AssetItem({
    this.assetId,
    this.symbol,
    this.name,
    this.iconUrl,
    this.balance,
    this.publicKey,
    this.priceBtc,
    this.priceUsd,
    this.chainId,
    this.changeBtc,
    this.changeUsd,
    this.hidden,
    this.confirmations,
    this.chainIconUrl,
    this.chainSymbol,
    this.accountName,
    this.accountTag
  });

  factory AssetItem.fromJson(Map<String, dynamic> json) => AssetItem(
    assetId: json["assetId"],
    symbol: json["symbol"],
    name: json["name"],
    iconUrl: json["iconUrl"],
    balance: json["balance"],
    publicKey: json["publicKey"],
    priceBtc: json["priceBtc"],
    priceUsd: json["priceUsd"],
    chainId: json["chainId"],
    changeUsd: json["changeUsd"],
    changeBtc: json["changeBtc"],
    hidden: json["hidden"],
    confirmations: json["confirmations"],
    chainIconUrl: json["chainIconUrl"],
    chainSymbol: json["chainSymbol"],
    accountName: json["accountName"],
    accountTag: json["accountTag"]
  );

  Map<String, dynamic> toJson() => {
    "assetId" : assetId,
    "symbol": symbol,
    "name" : name,
    "iconUrl" : iconUrl,
    "balance" : balance,
    "publicKey" : publicKey,
    "priceBtc" : priceBtc,
    "priceUsd" : priceUsd,
    "chainId" : chainId,
    "changeUsd" : changeUsd,
    "changeBtc" : changeBtc,
    "hidden" : hidden,
    "confirmations" : confirmations,
    "chainIconUrl" : chainIconUrl,
    "chainSymbol" : chainSymbol,
    "accountName" : accountName,
    "accountTag" : accountTag
  };

  Decimal btc() => Decimal.parse(balance) * Decimal.parse(priceBtc);
  Decimal usd() => Decimal.parse(balance) * Decimal.parse(priceUsd);
  
}