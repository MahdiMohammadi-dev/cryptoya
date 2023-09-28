import 'package:cryptoya/network/ResponseModel.dart';
import 'package:cryptoya/providers/CryptoDataprovider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Widgets/HomePageView.dart';
import 'Widgets/changeTheme.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);

  var defaultchoicechipsindex = 0;

  List<String> choicechiptitle = [
    "Top Marketcaps",
    "Top Gainers",
    "Top Losers"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cryptoprovider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoprovider.getTopMarketCapData();
  }

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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Marquee(
                        style: textTheme.bodySmall,
                        text:
                            "📣 Binance CEO CZ Under Investigation for Potential Criminal Charges, Reports WSJ 📣 Argentinian oil company to start mining crypto with gas power leftovers 📣 Challenges Emerge in Blockchain Censorship as Community Calls for Resistance Solutions"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                padding: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {},
                              child: const Text("Buy"))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                padding: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {},
                              child: const Text("Sell"))),
                    ],
                  ),
                ),

                ///TODO:ChoiceChip Section
                Padding(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Wrap(
                      spacing: 10,
                      children: List.generate(
                        choicechiptitle.length,
                        (index) {
                          return ChoiceChip(
                            label: Text(
                              choicechiptitle[index],
                              style: textTheme.titleSmall,
                            ),
                            selected: defaultchoicechipsindex == index,
                            selectedColor: Colors.blue,
                            onSelected: (value) {
                              setState(() {
                                defaultchoicechipsindex =
                                    value ? index : defaultchoicechipsindex;
                              });
                            },
                          );
                        },
                      )),
                ),
                Consumer<CryptoDataProvider>(
                  builder: (context, value, child) {
                    switch (value.state.status) {
                      case Status.Loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case Status.Completed:
                        return const Text("Done!");
                      case Status.Error:
                        return Text(value.state.message);
                      default:
                        return const Text("Defalut");
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
