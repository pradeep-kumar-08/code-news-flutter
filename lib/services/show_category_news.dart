// import 'package:dio/dio.dart';
// import 'package:newswithme/models/show_category.dart';

// class ShowCategoryNews {
//   List<ShowCategoryModel> categories = [];

//   Future<void> getCategorieNews(String category) async {
//     String url =
//         "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=bea76415935f491490874527358f6b3c";

//     try {
//       Dio dio = Dio();

//       Response response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'User-Agent': 'Mozilla/5.0', // Required for NewsAPI on free tier
//           },
//         ),
//       );

//       print(
//         "Status Code:================================ ${response.statusCode}",
//       );

//       var jsonData = response.data;

//       if (jsonData['status'] == 'ok') {
//         jsonData["articles"].forEach((element) {
//           if (element["urlToImage"] != null &&
//               element["description"] != null) {
//             ShowCategoryModel categoryModel = ShowCategoryModel(
//               title: element["title"],
//               description: element["description"],
//               url: element["url"],
//               urlToImage: element["urlToImage"],
//               content: element["content"],
//               author: element["author"],
//             );
//             categories.add(categoryModel);
//           }
//         });
//       }
//     } catch (e) {
//       print("Error fetching category news: $e");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newswithme/models/category_model.dart';
import 'package:newswithme/models/show_category.dart';
import 'package:newswithme/models/slider_model.dart';

class ShowCategoryNews {

  List<ShowCategoryModel> categories = [];

  Future<void> getCategorieNews(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=bea76415935f491490874527358f6b3c";
    var response = await http.get(Uri.parse(url));
    print(
      "Status Code:================================ ${response.statusCode}",
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}
