// import 'package:dio/dio.dart';
// import 'package:newswithme/models/artical_model.dart';

// class News {
//   List<ArticalModel> news = [];

//   Future<void> getNews() async {
//     String url =
//         "https://newsapi.org/v2/everything?q=tesla&from=2025-06-02&sortBy=publishedAt&apiKey=bea76415935f491490874527358f6b3c";

//     try {
//       Dio dio = Dio();

//       Response response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'User-Agent': 'Mozilla/5.0', // Fix for 426 error
//           },
//         ),
//       );

//       print(
//         "Status Code:===============news.dart================= ${response.statusCode}",
//       );

//       var jsonData = response.data;

//       if (jsonData['status'] == 'ok') {
//         jsonData["articles"].forEach((element) {
//           if (element["urlToImage"] != null &&
//               element["description"] != null) {
//             ArticalModel articalModel = ArticalModel(
//               title: element["title"],
//               description: element["description"],
//               url: element["url"],
//               urlToImage: element["urlToImage"],
//               content: element["content"],
//               author: element["author"],
//             );
//             news.add(articalModel);
//           }
//         });
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newswithme/models/artical_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News {
  List<ArticalModel> news = [];

  Future<void> getNews() async {
    DateTime now = DateTime.now();
DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

// Format to yyyy-MM-dd
String formattedDate =
    "${oneMonthAgo.year}-${oneMonthAgo.month.toString().padLeft(2, '0')}-${oneMonthAgo.day.toString().padLeft(2, '0')}";


    String url =
        // All articles about Tesla from the last month, sorted by recent first
        "https://newsapi.org/v2/everything?q=tesla&from=${formattedDate}&sortBy=publishedAt&apiKey=bea76415935f491490874527358f6b3c";
    var response = await http.get(Uri.parse(url));
    print(
      "Status Code:===============news,dart================= ${response.statusCode},${formattedDate}",
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticalModel articalModel = ArticalModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}
