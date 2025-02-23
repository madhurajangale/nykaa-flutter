import 'package:flutter/material.dart';
import 'ProductDetailPage.dart';

void main() {
  runApp(MyApp());
}

final List<Map<String, String>> productDetails = [
  {"name": "Sancia women ethnic palazzo set", "price": "₹2,500", "image": "assets/palazzo.png", "rating": "4.5"},
  {"name": "Indya peach embroided net Anarkali", "price": "₹5,000", "image": "assets/anarkali.png", "rating": "4.7"},
  {"name": "Dori pink Women wear Salwar Suit", "price": "₹1,200", "image": "assets/salwar.png", "rating": "4.3"},
  {"name": "Sareeka Pink net lehenga choli", "price": "₹800", "image": "assets/lehenga.png", "rating": "4.0"},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndianwearPage(),
    );
  }
}

class IndianwearPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Indianwear",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Add filter functionality
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ProductCard(
                    name: productDetails[index]["name"]!,
                    price: productDetails[index]["price"]!,
                    image: productDetails[index]["image"]!,
                    rating: productDetails[index]["rating"]!,
                  );
                },
                childCount: productDetails.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.52,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String rating;

  const ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductDetailPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              name: name,
              price: price,
              image: image,
              rating: rating,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: () {
                        // Add to wishlist functionality
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () {
                      showQuickViewDialog(context, name, price, image, rating);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Quick View",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 10, fontFamily: "Poppins")),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        SizedBox(width: 4),
                        Text(rating, style: TextStyle(fontSize: 10, color: Colors.black87)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(price, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showQuickViewDialog(BuildContext context, String name, String price, String image, String rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(7),
            height: 440,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image, height: 310, width: double.infinity, fit: BoxFit.cover),
                ),
                SizedBox(height: 10),
                Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 10),
                    SizedBox(width: 3),
                    Text(rating, style: TextStyle(fontSize: 10, color: Colors.black87)),
                  ],
                ),
                SizedBox(height: 3),
                Text(price, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                      },
                      child: Text("Add to Cart"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      child: Text("Close"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
