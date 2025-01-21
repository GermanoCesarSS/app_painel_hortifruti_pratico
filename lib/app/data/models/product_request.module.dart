import 'package:file_picker/file_picker.dart';

class ProductRequestModel {
  int? id;
  String name;
  num price;
  String unitOfMeasure;
  String? description;
  PlatformFile? imagem;
  int categoryId;

  bool get isKg => unitOfMeasure == 'KG';

  ProductRequestModel({
    this.id,
    required this.name,
    required this.price,
    required this.unitOfMeasure,
    this.imagem,
    this.description,
    required this.categoryId,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) {
    // Converte 'preco' para num, caso seja uma String
    num parsedPrice;
    if (json['preco'] is String) {
      parsedPrice = num.tryParse(json['preco']) ?? 0;
    } else if (json['preco'] is num) {
      parsedPrice = json['preco'];
    } else {
      parsedPrice = 0; // Valor padrão caso o tipo seja inesperado
    }

    return ProductRequestModel(
      id: json['id'],
      name: json['nome'],
      price: parsedPrice,
      unitOfMeasure: json['unidade'],
      imagem: json['imagem'] ?? '',
      categoryId: json['categoria_id'],
      description: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nome': name,
        'descricao': description,
        'preco': price,
        'unidade': unitOfMeasure,
        'categoria_id': categoryId,
        'posicao': 1,
      };
}
