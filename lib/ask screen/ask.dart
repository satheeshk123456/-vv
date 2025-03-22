import 'package:flutter/material.dart';
import 'package:vendorvibe/homepage.dart/home.dart';
import 'package:vendorvibe/login/loginpage.dart';

class Ask extends StatefulWidget {
  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<Ask> {
  bool isSellerSelected = false;
  bool isBuyerSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Left "Select Category" Text
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                "Select Category :",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Spacer to push buttons to center
            Spacer(),

            // Centered Toggle Buttons
            Center(
              child: Column(
                children: [
                  ToggleButton(
                    isSelected: isSellerSelected,
                    onTap: () {
                      setState(() {
                        isSellerSelected = !isSellerSelected;
                        isBuyerSelected = false; // Ensure only one is selected
                      });
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    imagePath:
                        "asset/images/seller.png", // Add a seller image to assets
                    label: "Seller",
                  ),
                  SizedBox(height: 40),
                  ToggleButton(
                    isSelected: isBuyerSelected,
                    onTap: () {
                      setState(() {
                        isBuyerSelected = !isBuyerSelected;
                        isSellerSelected = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    imagePath:
                        "asset/images/buyer.png", // Add a buyer image to assets
                    label: "Buyer",
                  ),
                ],
              ),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}

// Custom Toggle Button Widget
class ToggleButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String imagePath;
  final String label;

  ToggleButton({
    required this.isSelected,
    required this.onTap,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected
              ? Color.fromARGB(255, 178, 183, 169).withOpacity(0.8)
              : Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isSelected ? 15 : 5,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 50, height: 50), // Seller/Buyer Image
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
