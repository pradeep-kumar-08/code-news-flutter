// import 'package:dio/dio.dart';
// import 'package:newswithme/models/slider_model.dart';

// class Sliders {
//   List<SliderModel> sliders = [];

//   Future<void> getSlider() async {
//     String url =
//         "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=bea76415935f491490874527358f6b3c";

//     try {
//       Dio dio = Dio();

//       Response response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'User-Agent': 'Mozilla/5.0', // Helps prevent 426 errors
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
//             SliderModel sliderModel = SliderModel(
//               title: element["title"],
//               description: element["description"],
//               url: element["url"],
//               urlToImage: element["urlToImage"],
//               content: element["content"],
//               author: element["author"],
//             );
//             sliders.add(sliderModel);
//           }
//         });
//       }
//     } catch (e) {
//       print("Error fetching sliders: $e");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newswithme/models/slider_model.dart'; 

class Sliders {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
    // Top headlines from TechCrunch right now
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=bea76415935f491490874527358f6b3c";
    var response = await http.get(Uri.parse(url));
    print(
      "Status Code:================================ ${response.statusCode}",
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          SliderModel sliderModel = SliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(sliderModel);
        }
      });
    }
  }
}
