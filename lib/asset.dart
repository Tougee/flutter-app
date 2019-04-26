import 'dart:convert';

Asset assetFromJson(String str) {
  final jsonData = json.decode(str);
  return Asset.fromJson(jsonData);
}

String assetToJson(Asset asset) {
  final dyn = asset.toJson();
  return json.encode(dyn);
}

class Asset {
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
  String accountName;
  String accountTag;

  Asset({
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
    this.accountName,
    this.accountTag
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetId: json["asset_id"],
    symbol: json["symbol"],
    name: json["name"],
    iconUrl: json["icon_url"],
    balance: json["balance"],
    publicKey: json["public_key"],
    priceBtc: json["price_btc"],
    priceUsd: json["price_usd"],
    chainId: json["chain_id"],
    changeUsd: json["change_usd"],
    changeBtc: json["change_btc"],
    hidden: json["hidden"],
    confirmations: json["confirmations"],
    accountName: json["account_name"],
    accountTag: json["account_tag"]
  );

  Map<String, dynamic> toJson() => {
    "asset_id" : assetId,
    "symbol": symbol,
    "name" : name,
    "icon_url" : iconUrl,
    "balance" : balance,
    "public_key" : publicKey,
    "price_btc" : priceBtc,
    "price_usd" : priceUsd,
    "chainId" : chainId,
    "change_usd" : changeUsd,
    "change_btc" : changeBtc,
    "hidden" : hidden,
    "confirmations" : confirmations,
    "account_name" : accountName,
    "account_tag" : accountTag
  };
}