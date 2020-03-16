class Video{
  final String title;
  final String avatar;
  final String file_mp4;
  final String date_created;

  Video({this.title, this.avatar, this.file_mp4, this.date_created});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      title: json['title'],
      avatar: json['avatar'],
      file_mp4: json['file_mp4'],
      date_created: json['date_created'],
    );
  }
}

class Category{
  final String title;
  final String thumb;

  Category({this.title, this.thumb});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      title: json['title'],
      thumb: json['thumb'],
    );
  }
}

class Chat{
  final String name;
  final String message;

  Chat({this.name, this.message});
}