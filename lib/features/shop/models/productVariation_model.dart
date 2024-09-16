class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.stock = 0,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.image = '',
    this.description = '',
    required this.attributeValues,
  });

  /// Funcion vacia
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Convertir el model en una estructura de json para poder trabajar con Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Image': image,
      'Description': description,
      'AttributeValues': attributeValues,
    };
  }

  /// Map Json
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    final data = json;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: json['Image'] ?? '',
      description: json['Description'] ?? '',
      attributeValues: Map<String, String>.from(data['AttributeValues']),
    );
  }
}
