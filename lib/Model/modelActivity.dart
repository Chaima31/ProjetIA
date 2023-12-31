import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String categorie;
  String image;
  String lieu;
  int nbr_min;
  int prix;
  String titre;

  Activity(
      {required this.id,
      required this.categorie,
      required this.image,
      required this.lieu,
      required this.nbr_min,
      required this.prix,
      required this.titre});

  factory Activity.FromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Activity(
        id: doc.id,
        categorie: data['categorie'] ?? '',
        image: data['image'] ?? '',
        lieu: data['lieu'] ?? '',
        nbr_min: data['nombremin'] ?? 0,
        prix: data['prix'] ?? 0,
        titre: data['titre'] ?? '');
  }
}