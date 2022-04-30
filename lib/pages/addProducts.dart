import 'package:flutter/material.dart';
import 'package:usuariosproductosapp/main.dart';
import 'package:usuariosproductosapp/pages/listProducts.dart';

import '../controllers/databaseHelper.dart';

class AddDataProduct extends StatefulWidget {
  const AddDataProduct({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _AddDataProductState createState() => _AddDataProductState();
}

class _AddDataProductState extends State<AddDataProduct> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameController.addListener(() {
      setState(() {});
    });

    _priceController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(255, 187, 25, 25)),
      debugShowCheckedModeBanner: false,
      title: 'Nuevo producto',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo producto'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            SizedBox(
              height: 50,
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'El nombre de tu producto',
                  icon: Icon(Icons.playlist_add_circle_outlined),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _priceController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  hintText: 'Precio de este producto',
                  icon: Icon(Icons.price_change_outlined),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 44.0),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 44.0),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _nameController.text.isEmpty ||
                        _priceController.text.isEmpty
                    ? null
                    : () {
                        databaseHelper.addDataProduct(
                            _nameController.text.trim(),
                            _priceController.text.trim());

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ListProducts(),
                          ),
                          
                        );
                      },
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
