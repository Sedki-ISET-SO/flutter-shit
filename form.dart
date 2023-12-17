import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'model/item.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;
  List<Item> items = [];

  // Variables to store form data
  int? code;
  String? label;
  double? quantity;
  String? category;
  String? availability;
  String? salesType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Form')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Code (Numeric)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => code = int.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a code';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Label (Text)'),
                onSaved: (value) => label = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a label';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Quantity (Numeric: Real)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => quantity = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Product Category'),
                items: [
                  'Desktop Computer',
                  'Laptop',
                  'SmartPhone',
                  'Laser Printer'
                ]
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) => category = value,
              ),
              ...['Available', 'On Order'].map((String value) {
                return RadioListTile<String>(
                  title: Text(value),
                  value: value,
                  groupValue: availability,
                  onChanged: (String? newValue) {
                    setState(() {
                      availability = newValue;
                    });
                  },
                );
              }).toList(),
              ...['In-Store', 'Online'].map((String value) {
                return RadioListTile<String>(
                  title: Text(value),
                  value: value,
                  groupValue: salesType,
                  onChanged: (String? newValue) {
                    setState(() {
                      salesType = newValue;
                    });
                  },
                );
              }).toList(),
              Row(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _saveData();
                        }
                      },
                      child: const Text('Add')),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        category = null;
                        availability = null;
                        salesType = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              FutureBuilder<List<Item>>(
                future: fetchItems(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  if (snapshot.hasData) {
                    return DataTable(
                      columns: const [
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Label')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Availability')),
                        DataColumn(label: Text('Sales Type')),
                      ],
                      rows: snapshot.data!
                          .map((item) => DataRow(cells: [
                                DataCell(Text(item.code.toString())),
                                DataCell(Text(item.label)),
                                DataCell(Text(item.quantity.toString())),
                                DataCell(Text(item.category)),
                                DataCell(Text(item.availability)),
                                DataCell(Text(item.salesType)),
                              ]))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    final item = Item(
      code: code ?? 0, // Default to 0 if null
      label: label ?? '', // Default to empty string if null
      quantity: quantity ?? 0.0, // Default to 0.0 if null
      category: category ?? 'Unknown', // Default to 'Unknown' if null
      availability: availability ?? 'Unknown', // Default to 'Unknown' if null
      salesType: salesType ?? 'Unknown', // Default to 'Unknown' if null
    );

    await dbHelper.insertItem(item);
    _fetchAndSetItems();
  }

  void _fetchAndSetItems() async {
    List<Item> fetchedItems = await dbHelper.getAllItems();
    setState(() {
      items = fetchedItems;
    });
  }

  Future<List<Item>> fetchItems() async {
    return await dbHelper.getAllItems();
  }
}
