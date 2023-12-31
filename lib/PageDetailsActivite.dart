import 'package:flutter/material.dart';
import 'package:najalichaimaetpai2/Model/modelActivity.dart';

class PageDetailsActivite extends StatelessWidget {
  final Activity activity;

  PageDetailsActivite(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'activité'),
      ),
      body: Center(
        child: Container(
          width: 300, // Ajustez la largeur selon vos besoins
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Afficher l'image de l'activité
              Container(
                width: double.infinity,
                height: 200, // Ajustez la hauteur selon vos besoins
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(activity.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Titre: ${activity.titre}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Catégorie: ${activity.categorie}'),
              Text('Lieu: ${activity.lieu}'),
              Text('Nombre Minimum: ${activity.nbr_min}'),
              Text('Prix: ${activity.prix}'),
              // Ajoutez d'autres détails selon vos besoins
            ],
          ),
        ),
      ),
    );
  }
}
