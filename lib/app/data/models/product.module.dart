class ProductModel {
  int id;
  String name;
  num price;
  String unitOfMeasure;
  String? description;
  String imagem;
  int categpryId;

  bool get isKg => unitOfMeasure == 'KG';

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    required this.imagem,
    this.description,
    required this.categpryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Converte 'preco' para num, caso seja uma String
    num parsedPrice;
    if (json['preco'] is String) {
      parsedPrice = num.tryParse(json['preco']) ?? 0;
    } else if (json['preco'] is num) {
      parsedPrice = json['preco'];
    } else {
      parsedPrice = 0; // Valor padrão caso o tipo seja inesperado
    }

    return ProductModel(
      id: json['id'],
      name: json['nome'],
      price: parsedPrice,
      unitOfMeasure: json['unidade'],
      imagem: json['imagem'] ?? '',
      description: json['descricao'],
      categpryId: json['categoria_id'],
    );
  }
}
