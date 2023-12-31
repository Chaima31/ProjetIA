class Album{
   final int userId;
  final int id;
  final String title;
  
  Album({
    required this.userId, 
    required this.id,
    required this.title
  });

  Album.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
    id = json['id'],
    title = json['title'];

  Map<String, dynamic> toJson(){
    return {
      'userId' : userId,
      'id' : id,
      'title' : title,
    };
  }
  
}