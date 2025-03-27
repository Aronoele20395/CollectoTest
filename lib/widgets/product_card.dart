import 'package:collecto/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('${product.price}€',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('${product.sharePrice}€'),
                    ],
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF09EBB0)),
                    ),
                    child: const Text(
                      "Acquista ora",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
