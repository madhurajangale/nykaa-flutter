import 'package:flutter/material.dart';
import 'product.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Women'),
              Tab(text: 'Men'),
              Tab(text: 'Kids'),
              Tab(text: 'Home'),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryIcon('Sale 50% Off', Icons.local_offer),
                  _buildCategoryIcon('Trending', Icons.trending_up),
                  _buildCategoryIcon('New Arrivals', Icons.new_releases),
                  _buildCategoryIcon('Exclusive Brands', Icons.store),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  _buildCategoryItem(context, 'Indianwear', 'assets/indianwear.png'),
                  _buildCategoryItem(context, 'Westernwear', 'assets/westernwear.png'),
                  _buildCategoryItem(context, 'Jewellery', 'assets/jewellery.png'),
                  _buildCategoryItem(context, 'Watches', 'assets/watches.png'),
                  _buildCategoryItem(context, 'Footwear', 'assets/footwear.png'),
                  _buildCategoryItem(context, 'Bags', 'assets/bags.png'),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Stay Stylish'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String label, String imagePath) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      leading: Image.asset(imagePath, width: 70, height: 70),
      title: Text(
        label,
        style: TextStyle(fontSize: 15),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndianwearPage(), // Ensure `IndianwearPage` is defined in `product.dart`
          ),
        );
      },
    );
  }
}
