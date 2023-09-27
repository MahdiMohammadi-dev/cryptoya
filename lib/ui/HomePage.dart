import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Widgets/HomePageView.dart';
import 'Widgets/changeTheme.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "Cryptoya",
            style: textTheme.titleLarge,
          ),
          actions: const [
            ChangeTheme(),
          ],
        ),
        drawer: Drawer(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///TODO: PageView Section At HomePage "Top Of Screen"
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        HomePageView(
                          pageController: pageController,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: 4,
                              effect: const ExpandingDotsEffect(
                                dotHeight: 5,
                                dotWidth: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
