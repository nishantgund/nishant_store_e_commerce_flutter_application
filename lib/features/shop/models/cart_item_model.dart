class CartItemModel{
  String productId;
  String title;
  int price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = "",
    this.title = "",
    this.price = 0,
    this.image,
    this.brandName,
    this.selectedVariation
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJSON(){
    return {
      'productId' : productId,
      'title' : title,
      'price' : price,
      'image' : image,
      'quantity' : quantity,
      'variationId' : variationId,
      'brandName' : brandName,
      'selectedVariation' : selectedVariation
    };
  }

  factory CartItemModel.fromJSON(Map<String, dynamic> json){
    return CartItemModel(
        productId: json['productId'],
        title: json['title'],
        price: json['price'],
        image: json['image'],
        quantity: json['quantity'],
        variationId: json['variationId'],
        brandName: json['brandName'],
        selectedVariation: (json['selectedVariation'] as Map<String, dynamic>?) ?.map((key, value) => MapEntry(key.toString(), value.toString())),
    );
  }

}