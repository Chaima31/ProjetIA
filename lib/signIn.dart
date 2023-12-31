import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController emailC = TextEditingController();
TextEditingController passC = TextEditingController();

class SignInWidget extends StatelessWidget {
  const SignInWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 184, 91, 122),
        centerTitle: true,
        title: Text(
          "Najali Chaima et Pai ",
          style: TextStyle(
            color: const Color.fromARGB(255, 235, 228, 228), // Couleur du texte du logo
            fontSize: 24, // Taille de la police du logo
            fontWeight: FontWeight.bold, // Gras
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/ph.png'), // Change the path to your image
                fit: BoxFit.cover,
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Entrez votre e-mail',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailC.text,
                      password: passC.text,
                    );
        
                    // Si la connexion est réussie, vous pouvez accéder aux informations de l'utilisateur avec userCredential.user
                    print("Connexion réussie : ${userCredential.user?.email}");
                  } catch (e) {
                    // Si la connexion échoue, vous pouvez gérer l'erreur ici
                    print("Erreur de connexion : $e");
                  }
                },
                child: Text("Se connecter"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
