import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:najalichaimaetpai2/Model/Profil.dart';
import 'package:najalichaimaetpai2/NouvellePageModification.dart';
import 'package:najalichaimaetpai2/login_ecran.dart';

class PageProfil extends StatefulWidget {
  const PageProfil({Key? key}) : super(key: key);

  @override
  _PageProfilState createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController codePostalController = TextEditingController();
  TextEditingController anniversaireController = TextEditingController();
  TextEditingController villeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() {
    if (auth.currentUser != null) {
      loginController.text = auth.currentUser!.email ?? '';
    }
  }

  Future<void> _confirmerModification() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Êtes-vous sûr de vouloir modifier vos données ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Naviguer vers la page de modification
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NouvellePageModification()),
                );
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  void enregistrerModifications() async {
    // Mettez ici la logique pour enregistrer les modifications dans Firestore
    // Utilisez les contrôleurs mis à jour (nouveauLoginController, etc.)
    // ...

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Modifications enregistrées avec succès'),
      duration: Duration(seconds: 2),
    ));
  }

  void effacerChamps() {
    loginController.clear();
    passwordController.clear();
    adresseController.clear();
    codePostalController.clear();
    anniversaireController.clear();
    villeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Color.fromARGB(255, 254, 85, 167),
        centerTitle: true,
        shadowColor: Color.fromRGBO(247, 245, 245, 0.936),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login"),
              TextField(
                controller: loginController,
              ),
              SizedBox(height: 16),
              Text("Password"),
              TextField(
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 16),
              Text("Adresse"),
              TextField(
                controller: adresseController,
              ),
              SizedBox(height: 16),
              Text("Code Postal"),
              TextField(
                keyboardType: TextInputType.number,
                controller: codePostalController,
              ),
              SizedBox(height: 16),
              Text("Anniversaire"),
              TextField(
                controller: anniversaireController,
              ),
              SizedBox(height: 16),
              Text("Ville"),
              TextField(
                controller: villeController,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _confirmerModification();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Modifier"),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      enregistrerModifications();
                      effacerChamps();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Enregistrer"),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Email de l'utilisateur"),
                            content: Text(auth.currentUser?.email ?? "Aucun email"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Fermer"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Afficher Email"),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginEcran()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Déconnexion"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      effacerChamps();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                    ),
                    child: Text("Effacer"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
