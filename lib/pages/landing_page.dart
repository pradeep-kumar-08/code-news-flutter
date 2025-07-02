import 'package:flutter/material.dart';
import 'package:newswithme/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 13, vertical: 30),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "images/landingpage.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "News From around the \n        world for you",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Take a moment to read, and explore stories that\n               bring you closer to the world",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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
