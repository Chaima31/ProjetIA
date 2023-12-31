import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:najalichaimaetpai2/Model/modelActivity.dart';
import 'package:najalichaimaetpai2/PageAjoutActivite.dart';
import 'package:najalichaimaetpai2/PageDetailsActivite.dart';
import 'package:najalichaimaetpai2/PageProfil.dart'; // Assurez-vous d'importer la classe PageProfil

class ListeActivite extends StatefulWidget {
  const ListeActivite({Key? key});

  @override
  State<ListeActivite> createState() => _ListeActiviteState();
}

class _ListeActiviteState extends State<ListeActivite> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des activités"),
        backgroundColor: Color.fromARGB(255, 254, 85, 167),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AjoutActivite()));
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Rediriger vers la page de profil
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageProfil()), // Assurez-vous d'importer PageProfil
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection("activite").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No activities found.'),
                  );
                }

                List<Activity> activities = snapshot.data!.docs.map((doc) {
                  return Activity.FromFirestore(doc);
                }).toList();

                // Afficher la liste des activités dans un design personnalisé
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    Activity activity = activities[index];
                    return GestureDetector(
                      onTap: () {
                        // Naviguer vers la page de détails de l'activité lorsque l'élément est cliqué
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageDetailsActivite(activity)),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 8),
                              child: Image.network(
                                activity.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity.titre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Location: ${activity.lieu}'),
                                  Text('Price: ${activity.prix}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
