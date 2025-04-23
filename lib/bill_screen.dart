import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart';
import 'thankyou_screen.dart'; // <- import this

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  int getTotalPrice() {
    return cartItems.fold(0, (sum, item) {
      final price = int.tryParse(item['price'].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + price;
    });
  }

  Future<void> _showAddressDialog(BuildContext context) async {
    final TextEditingController _addressController = TextEditingController();
    final parentContext = context;

    await showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Enter Delivery Address"),
        content: TextField(
          controller: _addressController,
          decoration: const InputDecoration(hintText: "Your address"),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final address = _addressController.text.trim();
              if (address.isNotEmpty) {
                Navigator.pop(dialogContext);
                await _storeOrderDetails(parentContext, address);
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  Future<void> _storeOrderDetails(BuildContext context, String address) async {
    final total = getTotalPrice();
    final order = {
      'items': cartItems,
      'total': total,
      'address': address,
      'timestamp': Timestamp.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('orders').add(order);

      cartItems.clear(); // ✅ Clear cart

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ThankYouScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error placing order: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill Summary"),
        backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final price = int.tryParse(item['price'].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

                  return ListTile(
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text("₹$price"),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            ListTile(
              title: const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text("₹$total", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showAddressDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text("Place Order", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
