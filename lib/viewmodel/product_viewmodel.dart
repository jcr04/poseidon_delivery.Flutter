import '../models/product.dart';

class ProductViewModel {
  List<Product> get products => [
    Product(
      id: '1',
      name: 'Água Mineral 500ml',
      imageUrl: 'lib/assets/images/AguaMineral500ml.jpeg',
      description: 'Água mineral Crystal sem gás 500ml',
      price: 2.50,
    ),
    Product(
      id: '2',
      name: 'Água Mineral 1L',
      imageUrl: 'lib/assets/images/AguaMineral1L.png',
      description: 'Água mineral Crystal sem gás 1L',
      price: 4.50,
    ),
    Product(
      id: '3',
      name: 'Água Mineral 5L',
      imageUrl: 'lib/assets/images/AguaMineral5L.png',
      description: 'Água mineral Indaiá sem gás 5L',
      price: 10.00,
    ),
    Product(
      id: '4',
      name: 'Água Mineral com gás 500ml',
      imageUrl: 'lib/assets/images/ÁguaMineralcomgás500mL.png',
      description: 'Água mineral Crystal com gás 500ml',
      price: 3.00,
    ),
    Product(
      id: '5',
      name: 'Água Mineral com gás 1L',
      imageUrl: 'lib/assets/images/AguaMineralcomgás1L.png',
      description: 'Água mineral Indaiá com gás 1L',
      price: 5.00,
    ),
    Product(
      id: '6',
      name: 'Água Mineral com gás 2L',
      imageUrl: 'lib/assets/images/AguaMineralcomgás2L.jpeg',
      description: 'Água mineral da Pedra com gás 2L',
      price: 7.00,
    ),
    Product(
      id: '8',
      name: 'Galão de Água 20L',
      imageUrl: 'lib/assets/images/GalãodeÁgua20L.jpg',
      description: 'Galão de água Lindoya 20L',
      price: 20.00,
    ),
    Product(
      id: '9',
      name: 'Água Ouro Fino - 300ml - 08 Und',
      imageUrl: 'lib/assets/images/AguaOuroFino.jpg',
      description: 'Pack com 8 unidades de Água Ouro Fino 300ml',
      price: 22.00,
    ),
  ];
}
