class PaymentMethodModel{
  String name, image;
  String? id;
  PaymentMethodModel({required this.name, required this.image , this.id});

  static PaymentMethodModel empty() => PaymentMethodModel(name: "", image: "", id: "");

  factory PaymentMethodModel.fromSnapshot(Map<String, dynamic> data){
    return PaymentMethodModel(name: data['name'], image: data['image'], id: data['id']);
  }

}