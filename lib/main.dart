import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loja_0711/controller/shopping_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ShoppingView(),
    );
  }
}

class ShoppingView extends StatelessWidget {
  final ShoppingController _controller = Get.put(ShoppingController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              final quantity = int.tryParse(_quantityController.text) ?? 1;
              _controller.addItem(name, quantity);
              _nameController.clear();
              _quantityController.clear();
            },
            child: Text('Adicionar'),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (context, index) {
                  final item = _controller.items[index];
                  return ListTile(
                    title: Text('${item.name} - ${item.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _controller.deleteItem(item.id!),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
