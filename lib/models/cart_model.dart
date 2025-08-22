class CartModel {
  String productName;
  String productPrice;
  String productImage;
  String productQuantity;
  String productDesc;
  String productId;
  int quantity;

  CartModel(
      {required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.productQuantity,
      required this.productDesc,
      required this.productId,
      required this.quantity});

  // dart to json
  // Map<String, dynamic> toJson() {
  //   return {
  //     'Product Name': productName,
  //     'Product Image': productImage,
  //     'Product Price': productPrice,
  //     'Product Quantity': productQuantity,
  //     'Product Desc': productDesc,
  //     'quantity': quantity,
  //   };`
  // }

  Map<String, dynamic> toJson() {
    return {
      'Product Name':productName,
      
    };
  }

  // json to dart
  factory CartModel.fromJson(Map<String, dynamic> json, String id) {
    return CartModel(
        productName: json['Product Name'],
        productPrice: json['Product Price'],
        productImage: json['Product Image'],
        productQuantity: json['Product Quantity'],
        productDesc: json['Product Desc'],
        quantity: json['quantity'], 
        productId: id
        );
  }
}
