import 'package:flutter/material.dart';

class NouvellePageModification extends StatefulWidget {
  @override
  _NouvellePageModificationState createState() => _NouvellePageModificationState();
}

class _NouvellePageModificationState extends State<NouvellePageModification> {
  TextEditingController nouveauLoginController = TextEditingController();
  TextEditingController nouveauPasswordController = TextEditingController();
  TextEditingController nouvelleAdresseController = TextEditingController();
  TextEditingController nouveauCodePostalController = TextEditingController();
  TextEditingController nouvelAnniversaireController = TextEditingController();
  TextEditingController nouvelleVilleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le profil"),
        backgroundColor: Color.fromARGB(255, 254, 85, 167),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nouveau Login"),
              TextField(
                controller: nouveauLoginController,
              ),
              SizedBox(height: 16),
              Text("Nouveau Password"),
              TextField(
                obscureText: true,
                controller: nouveauPasswordController,
              ),
              SizedBox(height: 16),
              Text("Nouvelle Adresse"),
              TextField(
                controller: nouvelleAdresseController,
              ),
              SizedBox(height: 16),
              Text("Nouveau Code Postal"),
              TextField(
                keyboardType: TextInputType.number,
                controller: nouveauCodePostalController,
              ),
              SizedBox(height: 16),
              Text("Nouvel Anniversaire"),
              TextField(
                controller: nouvelAnniversaireController,
              ),
              SizedBox(height: 16),
              Text("Nouvelle Ville"),
              TextField(
                controller: nouvelleVilleController,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Ajoutez ici la logique pour mettre à jour les données dans Firestore
                  // après que l'utilisateur a appuyé sur le bouton de modification
                  // Assurez-vous d'utiliser les nouveaux contrôleurs (nouveauLoginController, etc.)
                },
                child: Text("Enregistrer les modifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
