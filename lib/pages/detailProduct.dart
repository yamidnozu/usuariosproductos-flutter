import 'package:flutter/material.dart';
import 'package:usuariosproductosapp/controllers/databaseHelper.dart';
import 'package:usuariosproductosapp/pages/editProduct.dart';
import 'package:usuariosproductosapp/pages/listProducts.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({required this.index, required this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  //create function delete
  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Esta seguto de eliminar el producto '${widget.list[widget.index]['name']}'"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            "Si",
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            databaseHelper
                .removeRegister(widget.list[widget.index]['_id'].toString());
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ListProducts(),
            ));
          },
        ),
        ElevatedButton(
          child: const Text("No", style: const TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.list[widget.index]['name']}")),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Text(
              widget.list[widget.index]['name'],
              style: const TextStyle(fontSize: 20.0),
            ),
            const Divider(),
            Text(
              "Precio : ${widget.list[widget.index]['price']}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  child: const Text("Editar"),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditProduct(
                      list: widget.list,
                      index: widget.index,
                    ),
                  )),
                ),
                const VerticalDivider(),
                RaisedButton(
                  child: const Text("Eliminar"),
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () => confirm(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
