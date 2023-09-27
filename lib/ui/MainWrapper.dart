import 'package:cryptoya/ui/HomePage.dart';
import 'package:cryptoya/ui/MarketViewPage.dart';
import 'package:cryptoya/ui/ProfiePage.dart';
import 'package:cryptoya/ui/WatchListPage.dart';
import 'package:cryptoya/ui/Widgets/BottomNav.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.compare_arrows_outlined),
      ),
      bottomNavigationBar: BottomNav(
        controller: pageController,
      ),
      body: PageView(
        allowImplicitScrolling: true,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
          WatchListPage()
        ],
      ),
    );
  }
}
