import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_sqflite/model/data_model.dart';
import 'package:local_storage_sqflite/service/db_service.dart';
import 'package:local_storage_sqflite/utils/form_helper.dart';

import 'add_edit_product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DBService dbService;

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Local Storage SQFlite"),
      ),
      body: _fetchData(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditProduct(),
            ),
          );
        },
      ),
    );
  }

  Widget _fetchData() {
    return FutureBuilder<List<ProductModel>>(
      future: dbService.getProducts(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductModel>> products) {
        if (products.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_buildDataTable(products.data!)],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildDataTable(List<ProductModel> model) {
    return DataTable(
      columns: [
        DataColumn(
          label: Expanded(
            child: Text(
              "Product Name",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Price",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Action",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      sortColumnIndex: 1,
      rows: model
          .map(
            (data) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Expanded(
                    child: Text(
                      data.productName!,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                DataCell(
                  Expanded(
                    child: Text(
                      data.price.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditProduct(
                                    isEditMode: true,
                                    model: data,
                                  ),
                                ),
                              );
                            },
                          ),
                          new IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              FormHelper.showMessage(
                                context,
                                "Local Storage",
                                "Do you want to delete this record?",
                                "Yes",
                                () {
                                  dbService.deleteProduct(data).then((value) {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  });
                                },
                                buttonText2: "No",
                                isConfirmationDialog: true,
                                onPressed2: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
