import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Data Add CMS',
      home: AddProduct(),
    );
  }
}

class AddProduct extends StatefulWidget {

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  _textField(
      TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  late Map<String, dynamic> productToAdd;
  
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection("products");
  
  addProduct(){
    productToAdd = {
      "name":nameController.text,
      "brand":brandController.text,
       "price":priceController.text,
      "imageurl":imageUrlController.text,
    };
    _collectionReference.add(productToAdd).whenComplete(() => print("Successfully Added"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Text(
                "PRODUCT ADD CMS",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              _textField(nameController, "Name"),
              SizedBox(height: 15),
              _textField(brandController, "Brand"),
              SizedBox(height: 15),
              _textField(priceController, "Pirce"),
              SizedBox(height: 15),
              _textField(imageUrlController, "Image Url"),
              SizedBox(height: 20),
              MaterialButton(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                color: logoGreen,
                  onPressed: (){
                  addProduct();
                  },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                        color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

