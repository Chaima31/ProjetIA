import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AjoutActivite extends StatefulWidget {
  const AjoutActivite({Key? key}) : super(key: key);

  @override
  _AjoutActiviteState createState() => _AjoutActiviteState();
}

class _AjoutActiviteState extends State<AjoutActivite> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Uint8List? _pickedImageBytes;
  var _recognitions;
  String categorie = '';
  String imageUrl = '';
  String lieu = '';
  int nombre_min = 0;
  int prix = 0;
  String titre = '';

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (!kIsWeb) {
        setState(() {
          _image = image;
          _pickedImageBytes = null;
        });
      } else {
        final pickedImageBytes = await image.readAsBytes();
        final recognitions = await detectObjects(pickedImageBytes);

        setState(() {
          _image = null;
          _pickedImageBytes = pickedImageBytes;
          _recognitions = recognitions;
        });
      }
    } else {
      print('No image has been picked');
    }
  }

  Future<List<ObjectRecognition>> detectObjects(Uint8List imageBytes) async {
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageBytes,
      asynch: true,
    );

    return recognitions != null
        ? recognitions.map((r) => ObjectRecognition.fromMap(r)).toList()
        : [];
  }

  Widget _buildSelectedImageWidget() {
    if (_image != null) {
      return Image.file(
        File(_image!.path),
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      );
    } else if (_pickedImageBytes != null) {
      return Image.memory(
        _pickedImageBytes!,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une activité"),
        backgroundColor: Color.fromARGB(255, 1, 29, 52),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choisir une image'),
              ),
              if (_image != null || _pickedImageBytes != null)
                _buildSelectedImageWidget(),
              if (_recognitions != null)
                Text(
                  'Détection d\'objets : $_recognitions',
                  style: TextStyle(fontSize: 16),
                ),
              _buildTextField("Libellé", (value) {
                setState(() {
                  categorie = value;
                });
              }),
              const SizedBox(height: 16),
              _buildTextField("Image URL", (value) {
                setState(() {
                  imageUrl = value;
                });
              }),
              const SizedBox(height: 16),
              if (imageUrl.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              _buildTextField("Lieu", (value) {
                setState(() {
                  lieu = value;
                });
              }),
              const SizedBox(height: 16),
              _buildNumberTextField("Nombre Minimum", (value) {
                setState(() {
                  nombre_min = int.tryParse(value) ?? 0;
                });
              }),
              const SizedBox(height: 16),
              _buildNumberTextField("Prix", (value) {
                setState(() {
                  prix = int.tryParse(value) ?? 0;
                });
              }),
              const SizedBox(height: 16),
              _buildTextField("Titre", (value) {
                setState(() {
                  titre = value;
                });
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Ajouter l'activité à Firestore
                  ajouterActiviteAFirestore();
                },
                child: Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberTextField(String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }

  void ajouterActiviteAFirestore() async {
    try {
      await firestore.collection("master2").add({
        'categorie': categorie,
        'image': imageUrl,
        'lieu': lieu,
        'nbr_min': nombre_min,
        'prix': prix,
        'titre': titre,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Activité ajoutée avec succès'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'activité dans Firestore : $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de l\'ajout de l\'activité'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

class ObjectRecognition {
  final String label;
  final double confidence;

  ObjectRecognition({required this.label, required this.confidence});

  factory ObjectRecognition.fromMap(Map<String, dynamic> map) {
    return ObjectRecognition(
      label: map['label'] ?? '',
      confidence: map['confidence'] ?? 0.0,
    );
  }
}
