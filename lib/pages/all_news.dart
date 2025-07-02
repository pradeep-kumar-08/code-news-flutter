import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newswithme/models/artical_model.dart';
import 'package:newswithme/models/slider_model.dart';
import 'package:newswithme/pages/artical_view.dart';
import 'package:newswithme/services/news.dart';
import 'package:newswithme/services/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticalModel> articles = [];

  @override
  void initState() {
    getNews();
    getSlider();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news; //list is here of news from news class
    setState(() {
      
    });
    
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders; //list is here of news from news class
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.news),centerTitle: true,elevation: 0.0,),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount:widget.news=="Breaking"? sliders.length:articles.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              Image:widget.news=="Breaking"?sliders[index].urlToImage!:articles[index].urlToImage!,
              desc: widget.news=="Breaking"?sliders[index].description!:articles[index].description!,
              title: widget.news=="Breaking"?sliders[index].title!:articles[index].title!,
              url: widget.news=="Breaking"?sliders[index].url!:articles[index].url!,
            );
          },
        ),
      ),);
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title,url;
  AllNewsSection({required this.Image, required this.desc, required this.title,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticalView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(desc, maxLines: 3),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

