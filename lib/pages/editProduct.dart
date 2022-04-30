import 'package:flutter/material.dart';
import 'package:usuariosproductosapp/controllers/databaseHelper.dart';
import 'package:usuariosproductosapp/pages/listProducts.dart';

class EditProduct extends StatefulWidget {
  final List list;
  final int index;

  const EditProduct({required this.list, required this.index});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController? controllerId;
  TextEditingController? controllerName;
  TextEditingController? controllerPrice;

  @override
  void initState() {
    controllerId = TextEditingController(
        text: widget.list[widget.index]['_id'].toString());
    controllerName = TextEditingController(
        text: widget.list[widget.index]['name'].toString());
    controllerPrice = TextEditingController(
        text: widget.list[widget.index]['price'].toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modificar producto"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerName,
                    validator: (value) {
                      if (value!.isEmpty) return "Nombre de producto";
                    },
                    decoration: const InputDecoration(
                      hintText: "Nombre",
                      labelText: "Nombre",
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  title: TextFormField(
                    controller: controllerPrice,
                    validator: (value) {
                      if (value!.isEmpty) return "Price";
                    },
                    decoration: const InputDecoration(
                      hintText: "Price",
                      labelText: "Price",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                ElevatedButton(
                  child: const Text("Guardar cambios"),
                  onPressed: () {
                    databaseHelper.editarProduct(
                      controllerId!.text.trim(),
                      controllerName!.text.trim(),
                      controllerPrice!.text.trim(),
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      maintainState: false,
                      builder: (BuildContext context) => ListProducts(),
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
