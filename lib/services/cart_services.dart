import 'package:bulk_basket/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartServices {
  final String userId;

  CartServices({required this.userId});
  CollectionReference get cartCollection => FirebaseFirestore.instance
      .collection('Cart')
      .doc(userId)
      .collection('Cart-Items');

  //add new item into cart
  Future<void> addCartItem(CartModel cartModel) async {
    await cartCollection.add(cartModel.toJson());
  }

  //get all cart items
  Future<List<CartModel>> getCartItems() async {
    QuerySnapshot snapshot = await cartCollection.get();
    return snapshot.docs.map((doc) {
      return CartModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  //update cartQuantity
  Future<void> updateCartQuantity(String productId, int newQuantity) async {
    await cartCollection.doc(productId).update({'quantity': newQuantity});
  }

  //delete cartQuantity
  Future<void> deleteCartItems(String productId) async {
    await cartCollection.doc(productId).delete();
  }
}
