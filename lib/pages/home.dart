import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newswithme/models/artical_model.dart';
import 'package:newswithme/models/category_model.dart';
import 'package:newswithme/models/slider_model.dart';
import 'package:newswithme/pages/all_news.dart';
import 'package:newswithme/pages/artical_view.dart';
import 'package:newswithme/pages/category_news.dart';
import 'package:newswithme/pages/slider_view.dart';
import 'package:newswithme/services/data.dart';
import 'package:newswithme/services/news.dart';
import 'package:newswithme/services/slider_data.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // get category insete the home list
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticalModel> articles = [];
  bool _isloading = true;

  // for active Window
  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news; //list is here of news from news class
    setState(() {
      _isloading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders; //list is here of news from news class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text("With"),
            Text(
              "Flutter",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      body:
          _isloading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              image: categories[index].image,
                              categoryName: categories[index].cateoryName,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Breaking News !",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              AllNews(news: "Breaking"),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View All ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      CarouselSlider.builder(
                        itemCount: sliders.length,
                        itemBuilder: (context, index, realIndex) {
                          String? res = sliders[index].urlToImage;
                          String? res1 = sliders[index].title;
                          return buildImage(res!, index, res1!);
                        },
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: true,
                          enlargeCenterPage: true,

                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(child: buildeIndicator()),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trending News !",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              AllNews(news: "Trending"),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View All ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 20),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              desc:
                                  articles[index].description ??
                                  "No description available",
                              imageUrl:
                                  articles[index].urlToImage ??
                                  "", // Fallback to empty string if null
                              title:
                                  articles[index].title ??
                                  "No title available", // Fallback to a default title if null
                              url: articles[index].url!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget buildImage(String image, int index, String name) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SliderView(sliderdesurl: sliders[index].url!),
        ),
      );
    },
    child: Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.only(top: 170),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  Widget buildeIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: SlideEffect(
      dotWidth: 15,
      dotHeight: 15,
      activeDotColor: Colors.blue,
    ),
  );
}

class CategoryTile extends StatelessWidget {
  // will pass image nd category name heer
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(name: categoryName.toString()),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 70,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),

              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({
    required this.desc,
    required this.imageUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticalView(blogUrl: url)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),

          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            size: 30,
                            color: Colors.grey[700],
                          ),
                        ),
                  ),
                  /*CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => Container(
                          height: 140,
                          width: 140,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey[700],
                          ),
                        ),
                  ), */
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      
                         Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
