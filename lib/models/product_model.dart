// class ProductModel {
//   String productName;
//   String productImage;
//   double productPrice;
//   String productQuantity;
//   String productDesc;

//   ProductModel(
//       {required this.productName,
//       required this.productImage,
//       required this.productPrice,
//       required this.productQuantity,
//       required this.productDesc});

//   Map<String, dynamic> toJson() {
//     return {
//       'productName': productName,
//       'productImage': productImage,
//       'productPrice': productPrice,
//       'productQuantity': productQuantity,
//       'productDesc': productDesc
//     };
//   }

//   factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
//     return ProductModel(
//         productName: json['productName'],
//         productImage: json['productImage'],
//         productPrice: json['productPrice'],
//         productQuantity: json['productQuantity'],
//         productDesc: json['productDesc']);
//   }
// }

// new model for product

class ProductModel {
  String productName;
  String productImage;
  double productPrice;
  String productQuantity;
  String productDesc;

  ProductModel(
      {required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productQuantity,
      required this.productDesc});

  // convet data: dart to json
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productDesc': productDesc
    };
  }

  // convert data : json to dart
  factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductModel(
        productName: json['productName'],
        productImage: json['productImage'],
        productPrice: json['productPrice'],
        productQuantity: json['productQuantity'],
        productDesc: json['productDesc']);
  }
  
}
