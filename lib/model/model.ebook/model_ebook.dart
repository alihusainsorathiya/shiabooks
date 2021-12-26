import 'package:json_annotation/json_annotation.dart';
part 'model_ebook.g.dart';

@JsonSerializable()
class ModelEbook {
  int id, catId, statusNews, pages, rating, free;
  String title,
      photo,
      description,
      pdf,
      date,
      authorName,
      publisherName,
      language;

  ModelEbook(
      {required this.id,
      required this.title,
      required this.photo,
      required this.description,
      required this.catId,
      required this.statusNews,
      required this.pdf,
      required this.date,
      required this.authorName,
      required this.publisherName,
      required this.pages,
      required this.language,
      required this.free,
      required this.rating});
  factory ModelEbook.fromJson(Map<String, dynamic> json) =>
      _$ModelEbookFromJson(json);

  Map<String, dynamic> toJson() => _$ModelEbookToJson(this);
}
