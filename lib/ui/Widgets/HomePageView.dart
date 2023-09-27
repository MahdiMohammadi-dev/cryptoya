import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  PageController pageController = PageController();
  HomePageView({super.key, required this.pageController});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  var images = [
    "assets/images/a1.png",
    "assets/images/a2.png",
    "assets/images/a3.png",
    "assets/images/a4.png",
  ];

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      allowImplicitScrolling: true,
      scrollDirection: Axis.horizontal,
      children: [
        myPage(
          images[0],
        ),
        myPage(
          images[1],
        ),
        myPage(
          images[2],
        ),
        myPage(
          images[3],
        ),
      ],
    );
  }

  Widget myPage(String imagename) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(
            image: AssetImage(imagename),
            fit: BoxFit.fill,
          )),
    );
  }
}
