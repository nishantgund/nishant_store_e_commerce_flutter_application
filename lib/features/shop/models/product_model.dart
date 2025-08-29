
class ProductModel {
  Brands? brands;
  int? categoryId;
  String? description;
  String? image;
  bool? isFeatured;
  int? price;
  ProductsAttributes? productsAttributes;
  ProductsVariation? productsVariation;
  String? sKU;
  int? salePrice;
  int? stock;
  String? title;
  String? productId;

  ProductModel(
      {required this.brands,
        required this.categoryId,
        required this.description,
        required this.image,
        required this.isFeatured,
        required this.price,
        required this.productsAttributes,
        required this.productsVariation,
        required this.sKU,
        required this.salePrice,
        required this.stock,
        required this.title,
        required this.productId
      });

  // JSON to Product Object
  ProductModel.fromJson(Map<String, dynamic> json) {
    //final json = documents.data()!;
      brands = json['Brands'] != null ? new Brands.fromJson(json['Brands']) : null;
      categoryId = json['CategoryId'] ?? 0;
      description = json['Description'] ?? "";
      image = json['Image'] ?? "";
      isFeatured = json['IsFeatured'] ?? false;
      price = json['Price'] ?? 0;
      productsAttributes = json['ProductsAttributes'] != null
          ? new ProductsAttributes.fromJson(json['ProductsAttributes'])
          : null;
      productsVariation = json['ProductsVariation'] != null
          ? new ProductsVariation.fromJson(json['ProductsVariation'])
          : null;
      sKU = json['SKU'] ?? "";
      salePrice = json['SalePrice'] ?? 0;
      stock = json['Stock'] ?? 0;
      title = json['Title'] ?? "";
      productId = json['productId'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      data['Brands'] = this.brands!.toJson();
    }
    data['CategoryId'] = this.categoryId;
    data['Description'] = this.description;
    data['Image'] = this.image ?? "";
    data['IsFeatured'] = this.isFeatured;
    data['Price'] = this.price;
    if (this.productsAttributes != null) {
      data['ProductsAttributes'] = this.productsAttributes!.toJson();
    }
    if (this.productsVariation != null) {
      data['ProductsVariation'] = this.productsVariation!.toJson();
    }
    data['SKU'] = this.sKU;
    data['SalePrice'] = this.salePrice;
    data['Stock'] = this.stock;
    data['Title'] = this.title;
    data['productId'] = this.productId;

    return data;
  }

  static ProductModel empty(){
    return ProductModel(
      brands: Brands.empty(),
      categoryId: null,
      description: "",
      image: "",
      isFeatured: null,
      price: null,
      productsAttributes: ProductsAttributes.empty(),
      productsVariation: ProductsVariation.empty(),
      sKU: "",
      salePrice: null,
      stock: null,
      title: "",
      productId: ""
    );
  }
}

class Brands {
  String? id;
  String? image;
  bool? isFeatured;
  String? name;
  int? productCount;

  Brands({
    this.id,
    this.image,
    this.isFeatured,
    this.name,
    this.productCount
  });

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['Image'];
    isFeatured = json['IsFeatured'];
    name = json['Name'];
    productCount = json['ProductCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Image'] = this.image;
    data['IsFeatured'] = this.isFeatured;
    data['Name'] = this.name;
    data['ProductCount'] = this.productCount;
    return data;
  }

  static Brands empty(){
    return Brands(
      id: "",
      image: "",
      isFeatured: null,
      name: "",
      productCount: null
    );
  }
}

class ProductsAttributes {
  One? one;
  One? two;

  ProductsAttributes({this.one, this.two});

  ProductsAttributes.fromJson(Map<String, dynamic> json) {
    one = json['One'] != null ? new One.fromJson(json['One']) : null;
    two = json['Two'] != null ? new One.fromJson(json['Two']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.one != null) {
      data['One'] = this.one!.toJson();
    }
    if (this.two != null) {
      data['Two'] = this.two!.toJson();
    }
    return data;
  }

  static ProductsAttributes empty(){
    return ProductsAttributes(one: One.empty(), two: One.empty());
  }
}

class One {
  String? name;
  Values? values;

  One({this.name, this.values});

  One.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    values =
    json['Values'] != null ? new Values.fromJson(json['Values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    if (this.values != null) {
      data['Values'] = this.values!.toJson();
    }
    return data;
  }

  static One empty(){
    return One(name: "", values: Values.empty());
  }
}

class Values {
  String? s2;
  String? one;
  String? two;

  Values({this.s2, this.one, this.two});

  Values.fromJson(Map<String, dynamic> json) {
    s2 = json['2'];
    one = json['One'];
    two = json['Two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2'] = this.s2;
    data['One'] = this.one;
    data['Two'] = this.two;
    return data;
  }

  static Values empty(){
    return Values(s2: "", one: "", two: "");
  }
}

class ProductsVariation {
  PVOne? one;
  PVOne? two;
  PVOne? three;

  ProductsVariation({this.one, this.two, this.three});

  ProductsVariation.fromJson(Map<String, dynamic> json) {
    one = json['One'] != null ? new PVOne.fromJson(json['One']) : null;
    two = json['Two'] != null ? new PVOne.fromJson(json['Two']) : null;
    three = json['Three'] != null ? new PVOne.fromJson(json['Three']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.one != null) {
      data['One'] = this.one!.toJson();
    }
    if (this.two != null) {
      data['Two'] = this.two!.toJson();
    }
    if (this.three != null) {
      data['Three'] = this.three!.toJson();
    }
    return data;
  }

  static ProductsVariation empty(){
    return ProductsVariation(one: PVOne.empty(),two: PVOne.empty(), three: PVOne.empty());
  }
}

class PVOne {
  AttributeValue? attributeValue;
  String? description;
  String? id;
  String? image;
  int? price;
  String? sKU;
  int? salePrice;
  int? stock;

  PVOne(
      {this.attributeValue,
        this.description,
        this.id,
        this.image,
        this.price,
        this.sKU,
        this.salePrice,
        this.stock});

  PVOne.fromJson(Map<String, dynamic> json) {
    attributeValue = json['AttributeValue'] != null
        ? new AttributeValue.fromJson(json['AttributeValue'])
        : null;
    description = json['Description'];
    id = json['Id'];
    image = json['Image'];
    price = json['Price'];
    sKU = json['SKU'];
    salePrice = json['SalePrice'];
    stock = json['Stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributeValue != null) {
      data['AttributeValue'] = this.attributeValue!.toJson();
    }
    data['Description'] = this.description;
    data['Id'] = this.id;
    data['Image'] = this.image;
    data['Price'] = this.price;
    data['SKU'] = this.sKU;
    data['SalePrice'] = this.salePrice;
    data['Stock'] = this.stock;
    return data;
  }

   static PVOne empty(){
    return PVOne(
      attributeValue: AttributeValue.empty(),
      description: "",
      id: "",
      image: "",
      price: null,
      sKU: "",
      salePrice: null,
      stock: null
    );
  }
}

class AttributeValue {
  String? color;
  String? size;

  AttributeValue({this.color, this.size});

  AttributeValue.fromJson(Map<String, dynamic> json) {
    color = json['Color'];
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Color'] = this.color;
    data['Size'] = this.size;
    return data;
  }

   static AttributeValue empty() => AttributeValue(color: "", size: "");

}
