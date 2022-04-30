import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:usuariosproductosapp/pages/detailProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List data = [];

  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    final urlUri = Uri(
      scheme: "http",
      host: "192.168.51.33",
      port: 3000,
      path: "products",
    );

    final response = await http.get(
      urlUri,
      headers: {
        "Accept": "application/json",
        "x-access-token": "$value",
      },
    );
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis productos"),
      ),
      body: VisibilityDetector(
        key: Key('my-widget-key'),
        onVisibilityChanged: (visibilityInfo) async {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          debugPrint(
              'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');

          if (visiblePercentage == 100) {
            data = await getData();
            setState(() {});
          }
        },
        child: data.isNotEmpty
            ? ItemList(list: data)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        return Container(
          
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  maintainState: false,
                  builder: (BuildContext context) => Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    Image.network('https://picsum.photos/200/300?random=2')
                        .image,
              ),
              title: Text(
                list[i]['name'].toString(),
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.orangeAccent,
                ),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Precio: \$ ${list[i]['price'].toString()}",
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
      itemCount: list == null ? 0 : list.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
    );
  }
}
