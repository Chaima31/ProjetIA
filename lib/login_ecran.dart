import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:najalichaimaetpai2/nvbar.dart';
import 'package:najalichaimaetpai2/signIn.dart';
//import 'package:najalichaimaetpai2/AccueilEcran.dart';
//import assets girl_avatar.png



class LoginEcran extends StatelessWidget {
  const LoginEcran({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Display a loading indicator when there's no user data
          return SignInWidget(); // Replace with your preferred placeholder widget
        }

        // Your existing code for the authenticated user
        return YourAuthenticatedUserWidget(); // Replace with the widget you want to display for authenticated users
      },
    );
  }
}

class YourAuthenticatedUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Inside StreamBuilder builder");

    // Navigate to the home page after successful login
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyNavBarButtom()),
      );
    });

    // Customized design for authenticated user
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Color(0xFFFFC0CB), // Light Pink color
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), // Change the path to your image
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                Text(
                  'Welcome to the App!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add your sign-out logic here
                    FirebaseAuth.instance.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // White color for the button
                  ),
                  child: Text("Sign Out", style: TextStyle(color: Colors.pink)),
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
