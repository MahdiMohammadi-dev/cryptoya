import 'package:dio/dio.dart';

class AllApi {
  dynamic getAllCryptoData() async {
    var url =
        "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=1000&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap";
    var response = await Dio().get(url);
    return response;
  }

  dynamic getTopMarketCapData() async {
    var url =
        "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap";

    var response = await Dio().get(url);
    print(response.data);
    return response;
  }

  dynamic getTopGainerData() async {
    var url =
        "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap";

    var response = await Dio().get(url);
    print(response.data);
    return response;
  }

  dynamic getTopLosersData() async {
    var url =
        "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=asc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap";

    var response = await Dio().get(url);
    print(response.data);
    return response;
  }

  dynamic callRegisterApi(name, email, password) async {
    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    });

    final response = await Dio().post(
      'https://besenior.ir/api/register',
      data: formData,
    );
    return response;
  }
}
