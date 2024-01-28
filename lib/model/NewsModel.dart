import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));
String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  String status;
  List<Datum> data;
  NewsModel({
    required this.status,
    required this.data,
  });
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        data: List<Datum>.from(json["articles"].map((x) => Datum.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? name;
  String? author;
  String? title;
  String? url;
  String? description;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Datum({
    required this.name,
    required this.author,
    required this.title,
    required this.url,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        author: json["author"],
        title: json["title"],
        url: json["url"],
        description: json["description"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };
}
