import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usuariosproductosapp/pages/addProducts.dart';
import 'package:usuariosproductosapp/pages/editProduct.dart';
import 'package:usuariosproductosapp/pages/listProducts.dart';
import 'package:usuariosproductosapp/pages/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dashboard productos",
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MainPage(), top: true),
      theme: ThemeData(primaryColor: Color.fromARGB(255, 187, 25, 25)),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Aplicación de productos", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences!.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: const Center(child: Text("Dashboard")),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
           
            ListTile(
              title: const Text("Listar productos"),
              trailing: const Icon(Icons.help),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ListProducts(),
              )),
            ),
            ListTile(
              title: const Text("Agregar productos"),
              trailing: const Icon(Icons.help),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    const AddDataProduct(title: "Agregar productos"),
              )),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
