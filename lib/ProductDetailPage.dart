import 'package:flutter/material.dart';
import 'cart.dart'; // <- Make sure this path is correct
import 'bag.dart';
class ProductDetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String rating;

  const ProductDetailPage({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(  // Makes the entire page scrollable
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    image,
                    width: 300,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Product Name
              Text(name, style: TextStyle(fontSize: 18, fontFamily: "Poppins")),
              SizedBox(height: 10),
              // Rating
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 15),
                  SizedBox(width: 5),
                  Text(rating, style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 10),
              // Price
              Text(price, style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: "Poppins", fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              // Product Description
              Text(
                "This is a great product. It offers a blend of style, comfort, and quality. Perfect for any occasion.",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              SizedBox(height: 20),
              // Select Size (like Nykaa)
              Text("Select Size", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
              SizedBox(height: 10),
              DropdownButton<String>(
                isExpanded: true,
                hint: Text("Choose a size"),
                items: <String>['S', 'M', 'L', 'XL', 'XXL'].map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle size selection
                },
              ),
              SizedBox(height: 20),
              // Product Details
              Text("Product Details", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
              SizedBox(height: 10),
              Text(
                "Material: Cotton\nBrand: XYZ\nCare: Hand wash\nColor: Red\nPattern: Solid",
                style: TextStyle(fontSize: 12, color: Colors.black87, fontFamily: "Poppins"),
              ),
              SizedBox(height: 20),
              // Delivery Date
              Text("Delivery Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
              SizedBox(height: 10),
              Text(
                "Expected delivery: 3-5 business days.",
                style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "Poppins"),
              ),
              SizedBox(height: 20),
              // Add to Cart Button
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      cartItems.add({
                        'name': name,
                        'price': price,
                        'image': image,
                        'rating': rating,
                        // You need to manage this state, see below
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to Cart')),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShoppingBagScreen()),
                      );
                    },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("Add to Cart", style: TextStyle(fontSize: 16, color: Colors.pink, fontFamily: "Poppins")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
