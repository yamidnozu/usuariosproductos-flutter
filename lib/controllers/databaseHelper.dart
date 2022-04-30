import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  var status;
  var token;

  void addDataProduct(String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    final urlUri = Uri(
      scheme: "http",
      host: "192.168.20.22",
      port: 3000,
      path: "products",
    );

    final response = await http.post(
      urlUri,
      body: {
        "name": name,
        "price": price,
      },
      headers: {
        "Accept": "application/json",
        "x-access-token": "$value",
      },
    );

    status = response.body.contains("error");

    var data = json.decode(response.body);
    if (status) {
      print(data);
    } else {
      print(data);
      //_save(data['token']);
    }
  }

//function for delete
  Future<void> removeRegister(String _id) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get('token') ?? 0;
    final urlUri = Uri(
      scheme: "http",
      host: "192.168.20.22",
      port: 3000,
      path: "product/$_id",
    );
    var res = await http.delete(
      urlUri,
      headers: {
        "Accept": "application/json",
        "x-access-token": "$value",
      },
    );

    if (res.statusCode == 200) {
      print("Emilinado");
    } else {
      throw "No es posible eliminar.";
    }
  }

  Future<void> getData() async {
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
    var data = json.decode(response.body);
  }

//function for update or put
  void editarProduct(String _id, String name, String price) async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.get('token') ?? 0;

    final urlUri = Uri(
      scheme: "http",
      host: "192.168.51.33",
      port: 3000,
      path: "product/$_id",
    );
    http.put(
      urlUri,
      body: {"name": name, "price": price},
      headers: {
        "Accept": "application/json",
        "x-access-token": "$value",
      },
    ).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
}

//function save
_save(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}

_read() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.get('token') ?? 0;
  print('read: $value');
  return value;
}
