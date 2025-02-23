import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/signup.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAW5s0V-w3tkFvHPi9jM7Qgi2o1EsT5624",
          authDomain: "nykaa-52e72.firebaseapp.com",
          projectId: "nykaa-52e72",
          storageBucket: "nykaa-52e72.firebasestorage.app",
          messagingSenderId: "496215769818",
          appId: "1:496215769818:web:89dd01ac04a2e3553d1be3",
          measurementId: "G-TRFYBXVMQZ"));
    print("✅ Firebase connected successfully!");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nykaa Fashion",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pinkbg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Skip Button
          Padding(
            padding: EdgeInsets.only(top: 40, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()), // Navigate to Login screen
                  );
                },
                child: Text(
                  "SignUp",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),

          /// Login Form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// App Title
                  Text(
                    "NYKAA FASHION",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),

                  SizedBox(height: 10),

                  /// Login/Signup Prompt
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 5),

                  /// Subtitle
                  Text(
                    "Stay stylish with the latest fashion",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: 20),

                  /// Phone Number Input
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),

                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "password",
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),

                  SizedBox(height: 20),

                  /// OTP Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NykaaHomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 10),

                  /// Terms & Conditions
                  Text(
                    "By continuing, I confirm that I am at least 18 years old, and agree to Terms & Conditions and Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
