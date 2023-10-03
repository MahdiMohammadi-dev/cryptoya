import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoya/Models/CryptoData.dart';
import 'package:cryptoya/logic/DecimalRounder.dart';
import 'package:cryptoya/providers/MarketViewProvidewr.dart';
import 'package:cryptoya/ui/Widgets/changeTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cryptoya/network/ResponseModel.dart' as pr;

class MarketViewPage extends StatefulWidget {
  const MarketViewPage({super.key});

  @override
  State<MarketViewPage> createState() => _MarketViewPageState();
}

class _MarketViewPageState extends State<MarketViewPage> {
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final marketviewprovider =
        Provider.of<MarketViewProvider>(context, listen: false);
    marketviewprovider.getCryptoData();

    timer = Timer.periodic(const Duration(seconds: 20),
        (timer) => marketviewprovider.getCryptoData());
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var primaryColor = Theme.of(context).primaryColor;
    var borderColor = Theme.of(context).secondaryHeaderColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: Theme.of(context).iconTheme,
        title: const Text("Market View"),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
        actions: const [ChangeTheme()],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Consumer<MarketViewProvider>(
                builder: (context, value, child) {
                  switch (value.state.status) {
                    case pr.Status.Loading:
                      return const Center(child: CircularProgressIndicator());
                    case pr.Status.Completed:
                      List<CryptoData>? model =
                          value.datafuture.data!.cryptoCurrencyList;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              onChanged: (value) {
                                //  List<CryptoData>? searchList = [];

                                //   for(CryptoData crypto in model!){
                                //     if(crypto.name!.toLowerCase().contains(value) || crypto.symbol!.toLowerCase().contains(value)){
                                //       searchList.add(crypto);
                                //     }
                                //   }
                                //   value.configSearch(searchList);
                              },
                              decoration: InputDecoration(
                                  hintStyle: textTheme.bodySmall,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: borderColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                          ),
                          Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    var number = index + 1;
                                    var tokenid = model![index].id;

                                    MaterialColor filtercolor =
                                        DecimalRounder.setColorFilter(
                                            model[index]
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

                                    return Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: size.height * 0.075,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  number.toString(),
                                                  style: textTheme.bodySmall,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: CachedNetworkImage(
                                                  fadeInDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  height: 32,
                                                  width: 32,
                                                  imageUrl:
                                                      "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenid.png",
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              Flexible(
                                                  fit: FlexFit.tight,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        model[index].name!,
                                                        style:
                                                            textTheme.bodySmall,
                                                      ),
                                                      Text(
                                                        model[index].symbol!,
                                                        style: textTheme
                                                            .labelSmall,
                                                      )
                                                    ],
                                                  )),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                      filtercolor,
                                                      BlendMode.srcATop),
                                                  child: SvgPicture.network(
                                                      "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenid.svg"),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "\$$finalprice",
                                                        style:
                                                            textTheme.bodySmall,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          percenticon,
                                                          Text(
                                                            percentChange + "%",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .ubuntu(
                                                                    color:
                                                                        percentcolor,
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: model!.length)),
                        ],
                      );
                    case pr.Status.Error:
                      return Text(value.state.message);
                    default:
                      return const Text("Default");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
