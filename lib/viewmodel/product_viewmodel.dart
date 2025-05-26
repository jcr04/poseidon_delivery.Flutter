import '../models/product.dart';

class ProductViewModel {
  List<Product> get products => [
    Product(
      id: '1',
      name: 'Água Mineral 500ml',
      imageUrl: 'lib/assets/images/GalãodeÁgua20L.jpg',
      description: 'Água mineral Crystal sem gás 500ml',
      price: 2.50,
    ),
    // Adicione os outros produtos aqui...
  ];
}
