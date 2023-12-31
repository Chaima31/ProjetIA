class Profil {
  final String login;
  final String password;
  final String adresse;
  final int codePostal;
  final String anniversaire;
  final String ville;

  Profil({
    required this.login,
    required this.password,
    required this.adresse,
    required this.codePostal,
    required this.anniversaire,
    required this.ville, required String userId,
  });

  // Méthode pour convertir le modèle en une Map (utilisé pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'password': password,
      'adresse': adresse,
      'code_postal': codePostal,
      'anniversaire': anniversaire,
      'ville': ville,
    };
  }

  // Méthode pour créer un modèle à partir d'une Map (utilisé lors de la récupération depuis Firestore)
  factory Profil.fromMap(Map<String, dynamic> map) {
    return Profil(
      //userId: map['userId'] ?? '',
      userId: map['userId'] ?? '',
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      adresse: map['adresse'] ?? '',
      codePostal: map['code_postal'] ?? 0,
      anniversaire: map['anniversaire'] ?? '',
      ville: map['ville'] ?? '',
    );
  }
}
