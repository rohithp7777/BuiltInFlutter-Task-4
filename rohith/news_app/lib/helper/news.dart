import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';
import 'package:news_app/models/headline_model.dart';
import 'dart:convert';
import 'package:news_app/secret.dart';

class News {

  List<Article> news  = [];

  Future<void> getNews() async{

    String url = 'https://newsapi.org/v2/everything?q=the&sortBy=popularity&language=en&apiKey=${apiKey}';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    //log('tag:$jsonData');
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}

class Headlines {

  List<HeadlineModel> headlines  = [];

  Future<void> getHeadlines() async{

    String url = 'http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=popularity&language=en&apiKey=${apiKey}';

    var response = await http.get(Uri.parse(url));
    print(response);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          HeadlineModel head = HeadlineModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            articleUrl: element["url"],
          );
          headlines.add(head);
        }

      });
    }

  }


}

class NewsForCategorie {

  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }

}
