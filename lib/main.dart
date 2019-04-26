import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/asset_item.dart';
import 'package:flutter_app/dao/asset_dao.dart';
import 'package:flutter_app/database.dart';
import 'package:flutter_app/percent_painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const Color gray = Color(0xffbbbec3);

  List<double> getPercents(Decimal totalUsd, List<AssetItem> assets) {
    var list = assets.where((a) => Decimal.parse(a.balance).compareTo(Decimal.fromInt(0)) != 0)
      .map((a) => double.parse((a.usd() / totalUsd).toStringAsFixed(2))).toList();
    list.sort((d1, d2) => (d1 - d2).toInt());
    var len = list.length;
    if(len == 1) {
      return [1];
    } else if(len == 2) {
      return [list[0], 1 - list[0]];
    } else {
      return [list[0], list[1], 1 - list[0] - list[1]];
    }
  }

  ListTile buildListTile(BuildContext context, AssetItem asset) {
    return ListTile(
      leading: ExcludeSemantics(
          child: CircleAvatar(backgroundImage: NetworkImage(asset.iconUrl))),
      title: Text(asset.name),
      subtitle: Text(asset.symbol),
      trailing: Text(asset.changeBtc),
    );
  }

  Widget buildHeader(BuildContext context, String btcValue, String usdValue, List<double> list) {
    return Column(children: <Widget>[
      SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "\$",
            style: TextStyle(color: gray, fontSize: 14),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            usdValue,
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontFamily: "mixin"),
          )
        ],
      ),
      SizedBox(
        height: 16,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            btcValue,
            style: TextStyle(
                color: Color(0xff333333), fontSize: 18, fontFamily: "mixin"),
          ),
          SizedBox(
            width: 8,
          ),
          const Text(
            "BTC",
            style: TextStyle(color: gray, fontSize: 14),
          )
        ],
      ),
      SizedBox(
        height: 24,
      ),
      Container(
        width: 300,
        height: 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: <BoxShadow> [
            BoxShadow(
              color: gray
            )
          ]
        ),
        child: CustomPaint(
          painter: PercentPainter(list),
        ),
      ),
      SizedBox(
        height: 50,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Wallet"),
        actions: <Widget>[Icon(Icons.menu)],
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<AssetItem>>(
          future: AssetDao(DBProvider.db).assetItemsNotHidden(),
          builder:
              (BuildContext context, AsyncSnapshot<List<AssetItem>> assets) {
            if (assets.hasData) {
              var totalBtc = Decimal.fromInt(0);
              var totalUsd = Decimal.fromInt(0);
              assets.data.forEach((a) {
                totalBtc += a.btc();
                totalUsd += a.usd();
              });
              final btcValue = totalBtc.toStringAsFixed(8);
              final usdValue = totalUsd.toStringAsFixed(2);

              return ListView.builder(
                  itemCount: assets.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return buildHeader(context, btcValue, usdValue, getPercents(totalUsd, assets.data));
                    } else {
                      return buildListTile(context, assets.data[index - 1]);
                    }
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
