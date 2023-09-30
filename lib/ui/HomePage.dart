import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoya/Models/CryptoData.dart';
import 'package:cryptoya/logic/DecimalRounder.dart';
import 'package:cryptoya/network/ResponseModel.dart';
import 'package:cryptoya/providers/CryptoDataprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
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
    var size = MediaQuery.of(context).size;
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ///TODO: PageView Section At HomePage "Top Of Screen"
                PageViewSection(pageController: pageController),

                ///TODO:News Section
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
                BuyAndSellButton(),

                ///TODO:ChoiceChip Section
                ChoiceChipSection(textTheme),
                SizedBox(
                  height: 500,
                  child: Consumer<CryptoDataProvider>(
                    builder: (context, value, child) {
                      switch (value.state.status) {
                        case Status.Loading:
                          return SizedBox(
                              height: 50,
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.white,
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return CryptoListSection();
                                    },
                                  )));
                        case Status.Completed:
                          List<CryptoData>? model =
                              value.datafuture.data!.cryptoCurrencyList;
                          // print("This is Symbol: ${model![0].symbol}");
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                var number = index + 1;
                                var tokenid = model![index].id;

                                MaterialColor filtercolor =
                                    DecimalRounder.setColorFilter(model[index]
                                        .quotes![0]
                                        .percentChange24h);

                                var finalprice =
                                    DecimalRounder.removePercentDecimals(
                                        model[index].quotes![0].price);
                                var percentChange =
                                    DecimalRounder.removePercentDecimals(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                Color percentcolor =
                                    DecimalRounder.setPercentChangesColor(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                Icon percenticon =
                                    DecimalRounder.setPercentChangesIcon(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);

                                return SizedBox(
                                  height: size.height * 0.075,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          number.toString(),
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 15),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          height: 32,
                                          width: 32,
                                          imageUrl:
                                              "https://s2.coinmarketcap.com/static/img/coins/64x64/$tokenid.png",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model[index].name!,
                                                style: textTheme.bodySmall,
                                              ),
                                              Text(
                                                model[index].symbol!,
                                                style: textTheme.labelSmall,
                                              )
                                            ],
                                          )),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              filtercolor, BlendMode.srcATop),
                                          child: SvgPicture.network(
                                              "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenid.svg"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\$$finalprice",
                                                style: textTheme.bodySmall,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  percenticon,
                                                  Text(
                                                    percentChange + "%",
                                                    style: GoogleFonts.ubuntu(
                                                        color: percentcolor,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: model!.length);
                        case Status.Error:
                          return Text(value.state.message);
                        default:
                          return const Text("Defalut");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Padding ChoiceChipSection(TextTheme textTheme) {
    return Padding(
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
    );
  }
}

class CryptoListSection extends StatelessWidget {
  const CryptoListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Icon(Icons.add),
          ),
        ),
        Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: 25,
                      height: 15,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: 70,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
              ),
            )),
        Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 50,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: 25,
                      height: 15,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class BuyAndSellButton extends StatelessWidget {
  const BuyAndSellButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class PageViewSection extends StatelessWidget {
  const PageViewSection({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
