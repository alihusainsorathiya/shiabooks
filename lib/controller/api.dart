class Apiconstant {
  String baseurl = 'https://shiabooks.000webhostapp.com/';
  // String baseurl = 'http://192.168.0.103:80/ebookapp/';
  static const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS"
  };
  String slider = 'slider';
  String api = 'api.php?';
  String latest = 'latest';
  String category = 'category';
  String incoming = 'coming';
  String register = 'utils/register.php';
  String login = 'utils/login.php';
  String viewPhoto = 'utils/viewphoto.php';
  String favorite = 'favorite=';
  String detail = 'pdf_by_id=';
  String saveFavourite = 'utils/save_favorite.php';
  String checkFavourite = 'utils/checkfav.php';
}
