import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage_sqflite/model/data_model.dart';
import 'package:local_storage_sqflite/pages/home_page.dart';
import 'package:local_storage_sqflite/service/db_service.dart';
import 'package:local_storage_sqflite/utils/form_helper.dart';

class AddEditProduct extends StatefulWidget {
  AddEditProduct({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  ProductModel? model;
  bool? isEditMode;

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  late ProductModel model;
  late DBService dbService;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    model = new ProductModel();

    if (widget.isEditMode!) {
      model = widget.model!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode! ? "Edit Product" : "Add Product"),
      ),
      body: new Form(
        key: globalFormKey,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("Product Name"),
                FormHelper.textInput(
                  context,
                  model.productName,
                  (value) => {
                    this.model.productName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Product Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Product Description"),
                FormHelper.textInput(
                    context,
                    model.productDesc,
                    (value) => {
                          this.model.productDesc = value,
                        },
                    isTextArea: true, onValidate: (value) {
                  return null;
                }),
                FormHelper.fieldLabel("Product Price"),
                FormHelper.textInput(
                  context,
                  model.price,
                  (value) => {
                    this.model.price = double.parse(value),
                  },
                  isNumberInput: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter price.';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter valid price.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Product Category"),
                _productCategory(),
                FormHelper.fieldLabel("Select Product Photo"),
                SizedBox(height: 10),
                FormHelper.picPicker(
                  model.productPic,
                  (file) => {
                    setState(
                      () {
                        model.productPic = file.path;
                      },
                    )
                  },
                ),
                SizedBox(height: 10),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productCategory() {
    return FutureBuilder<List<CategoryModel>>(
      future: dbService.getCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryModel>> categories) {
        if (categories.hasData) {
          return FormHelper.selectDropdown(
            context,
            model.categoryId,
            categories.data,
            (value) => {this.model.categoryId = int.parse(value)},
            onValidate: (value) {
              if (value == null) {
                return 'Please enter Product Category.';
              }
              return null;
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget btnSubmit() {
    return new Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (validateAndSave()) {
            print(model.toMap());
            if (widget.isEditMode!) {
              dbService.updateProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "Local Storage",
                  "Data Submitted Successfully",
                  "Ok",
                  () {
                    Navigator.pushAndRemoveUntil(context,
                        new MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }), (route) => route.isCurrent);
                  },
                );
              });
            } else {
              dbService.addProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "Local Storage",
                  "Data Modified Successfully",
                  "Ok",
                  () {
                    Navigator.pushAndRemoveUntil(context,
                        new MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }), (route) => route.isCurrent);
                  },
                );
              });
            }
          }
        },
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(10),
          width: 100,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              "Save Product",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
