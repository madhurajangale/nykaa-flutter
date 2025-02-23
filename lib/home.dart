import 'package:flutter/material.dart';
import 'category.dart';
import 'bag.dart';

void main() {
  runApp(MyApp());
}
final List<Map<String, String>> productDetails = [
  {"tagline": "Flat 30% off", "description": "Puma"},
  {"tagline": "Buy 1 Get 1", "description": "Marks and Spencer"},
  {"tagline": "New Arrivals", "description": "Miraggio"},
  {"tagline": "Best Seller", "description": "Levis"},
  {"tagline": "Special Discount", "description": "HopScotch"},
  {"tagline": "Hot Deal", "description": "Nayam"},
];
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NykaaHomePage(),
    );
  }
}

class NykaaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset('assets/nykaa_logo.png', height: 40),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingBagScreen()), // Replace with your target screen
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search earrings",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Category Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ["Women", "Men", "Kids", "Home"].map((category) {
                  return Chip(
                    label: Text(category),
                    backgroundColor: Colors.pink.shade100,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),

            // Scrollable Categories
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10), // Padding around the entire list
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10), // Space between the cards
                    child: CategoryCard(category: "Westernwear", image: "assets/westernwear.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CategoryCard(category: "Indianwear", image: "assets/indianwear.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CategoryCard(category: "Footwear", image: "assets/footwear.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CategoryCard(category: "Winterwear", image: "assets/winterwear.png"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),


            // Offer Banner
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/offer_banner.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 10),

            // Sale Banner
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/sale_banner.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 20),

            // Grid Section (2 columns, 3 rows)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: productDetails.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    image: "assets/product${index + 1}.png",
                    tagline: productDetails[index]["tagline"]!,
                    description: productDetails[index]["description"]!,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black, // Set selected icon color
        unselectedItemColor: Colors.grey, // Set unselected icon color
        backgroundColor: Colors.white, // Ensure background is visible
        showUnselectedLabels: true, // Show labels even when unselected
        type: BottomNavigationBarType.fixed, // Keeps icons and text aligned
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesPage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Stay Stylish'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

// Category Card Widget
class CategoryCard extends StatelessWidget {
  final String category;
  final String image;

  const CategoryCard({required this.category, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 30,
        ),
        SizedBox(height: 5),
        Text(category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),

      ],
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final String image;
  final String tagline;
  final String description;

  const ProductCard({required this.image, required this.tagline, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.cover, width: double.infinity),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tagline, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 5),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
