import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: AddProduct(),
    );
  }
}

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true, labelText: 'Producto'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Teorica'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Real'),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              RawMaterialButton(
                fillColor: Colors.white,
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width / 2, 60),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('DESCARTAR',
                        style: TextStyle(fontWeight: FontWeight.w800))
                  ],
                ),
                // shape: new CircleBorder(),
                elevation: 5,
              ),
              RawMaterialButton(
                fillColor: Colors.orange,
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width / 2, 60),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('CONFIRMAR',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: Colors.white))
                  ],
                ),
                // shape: new CircleBorder(),
                elevation: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
