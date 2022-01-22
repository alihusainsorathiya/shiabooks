import 'package:dio/dio.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';

Future<List<ModelEbook>> fetchFavorite(
    List<ModelEbook> fetch, String id) async {
  print("Get Favorites Base_url: " +
      Apiconstant().baseurl +
      Apiconstant().api +
      Apiconstant().favorite +
      id);
  String favurl =
      Apiconstant().baseurl + Apiconstant().api + Apiconstant().favorite + id;
  var request = await Dio().get(favurl);
  // var request = await Dio()
  //     .get("https://shiabooks.000webhostapp.com/api.php?favorite=10");
  print('inside favorites');
  print("request data :" + request.data.toString());
  print(request.statusCode);

  for (Map<String, dynamic> ebook in request.data) {
    print('inside for loop');

    fetch.add(ModelEbook(
      id: ebook['id'],
      title: ebook['title'].toString(),
      photo: ebook['photo'].toString(),
      description: ebook['description'].toString(),
      catId: ebook['cat_id'],
      statusNews: ebook['status_news'],
      pdf: ebook['pdf'].toString(),
      date: ebook['date'].toString(),
      authorName: ebook['author_name'].toString(),
      publisherName: ebook['publisher_name'].toString(),
      pages: ebook['pages'],
      language: ebook['language'].toString(),
      rating: ebook['rating'],
      free: ebook['free'],
    ));
    // fetch.add(ModelEbook(
    //   id: ebook['id'],
    //   title: ebook['title'],
    //   photo: ebook['photo'],
    //   description: ebook['description'],
    //   catId: ebook['cat_id'],
    //   statusNews: ebook['status_news'],
    //   pdf: ebook['pdf'],
    //   date: ebook['date'],
    //   authorName: ebook['author_name'],
    //   publisherName: ebook['publisher_name'],
    //   pages: ebook['pages'],
    //   language: ebook['language'],
    //   rating: ebook['rating'],
    //   free: ebook['free'],
    // ));
  }

  return fetch;
}
