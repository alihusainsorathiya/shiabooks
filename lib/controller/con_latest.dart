import 'package:dio/dio.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';

Future<List<ModelEbook>> fetchLatest(List<ModelEbook> fetch) async {
  print("Base_url: " +
      Apiconstant().baseurl +
      Apiconstant().api +
      Apiconstant().latest);
  var request = await Dio()
      .get(Apiconstant().baseurl + Apiconstant().api + Apiconstant().latest);
  for (Map<String, dynamic> ebook in request.data) {
    fetch.add(ModelEbook(
      id: ebook['id'],
      title: ebook['title'],
      photo: ebook['photo'],
      description: ebook['description'],
      catId: ebook['cat_id'],
      statusNews: ebook['status_news'],
      pdf: ebook['pdf'],
      date: ebook['date'],
      authorName: ebook['author_name'],
      publisherName: ebook['publisher_name'],
      pages: ebook['pages'],
      language: ebook['language'],
      free: ebook['free'],
      rating: ebook['rating'],
    ));
  }
  return fetch;
}
