import 'package:bulk_basket/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductService {
  final DocumentReference categoryCollection =
      FirebaseFirestore.instance.collection('New Product').doc('Category');

  Future<List<ProductModel>> getRiceAndFlourCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Rice and floor').get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getSnacksAndBiscuitsCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Snacks & Biscuits').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getDryFruitsCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Dry Fruits').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getSpicesCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Spices').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getCerealsCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Cereals').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getSkinCareCategoryItems() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Skin Care').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getGroomingItemCategory() async {
    QuerySnapshot snapshot =
        await categoryCollection.collection('Grooming Items').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
