import 'package:flutter/material.dart';
import 'cart.dart'; // <- Make sure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingBagScreen(),
    );
  }
}

class ShoppingBagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          "Bag",
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Wishlist",
              style: TextStyle(color: Colors.pinkAccent, fontSize: 14),
            ),
          ),
        ],
      ),
      body: Column(
        children: [


          // UPI Discount Info
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue[50],
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue),
                SizedBox(width: 8),
                Text("Flat discount on UPI payment"),
              ],
            ),
          ),

          // Check Delivery Date Section
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.local_shipping_outlined, color: Colors.black),
                const SizedBox(width: 10),
                const Text("Check Delivery Date"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Enter Pincode"),
                ),
              ],
            ),
          ),

          // Product List
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ProductItem(
                  imageUrl: item['image'],
                  brand: item['name'],
                  title: "Rating: ${item['rating']}",
                  size: item['size'] ?? 'Size not selected',
                  price: int.tryParse(item['price'].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                  originalPrice: 0,
                  discount: '',
                );
              },
            ),

          ),

          // Savings Section
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green[50],
            child: const Text(
              "You will save ₹6,978 on this purchase.",
              style: TextStyle(color: Colors.green, fontSize: 12),
            ),
          ),

          // Total Price & Proceed to Buy Button
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "₹7,849",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View Details", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onPressed: () {},
                  child: const Text("Proceed to Buy", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String title;
  final String size;
  final int price;
  final int originalPrice;
  final String discount;

  const ProductItem({
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.size,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: imageUrl.contains("http")
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 5),
                Text(size, style: const TextStyle(fontSize: 11)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text("₹$price", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Text(
                      "₹$originalPrice",
                      style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    Text(discount, style: const TextStyle(fontSize: 12, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 5),
                const Text("7 day return", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
