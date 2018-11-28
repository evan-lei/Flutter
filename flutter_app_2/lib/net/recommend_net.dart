import 'dart:io';
import 'dart:convert';
import 'package:flutter_app_2/model/toutiao.dart';

class RecommendNet{
  bool isLoading = false;

  Future<ToutiaoResponseModel> getData(bool isFresh, String type) async {
//    var url = 'http://v.juhe.cn/toutiao/index?type='+type+'&key=aa4e398ed507e49248714b7ff097e93e';
//    var httpClient = new HttpClient();
//    ToutiaoResponseModel responseModel;
//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//      var response = await request.close();
//      if (response.statusCode == HttpStatus.ok) {
//        var jsonString = await response.transform(Utf8Decoder()).join();
//        var jsonResponse = json.decode(jsonString);
//        var result = jsonResponse['result'];
//        print(result);
//        responseModel = ToutiaoResponseModel.fromJson(result);
//      }
//      else {
//        print('response error');
//      }
//    }
//    catch (exception) {
//      print('exception');
//    }
//    return responseModel;

    if (isLoading) {
      return new Future<ToutiaoResponseModel>((){
        return null;
      });
    }

    return new Future<ToutiaoResponseModel>(() async{
      isLoading = true;
      var url = 'http://v.juhe.cn/toutiao/index?type='+type+'&key=aa4e398ed507e49248714b7ff097e93e';
      var httpClient = new HttpClient();
      ToutiaoResponseModel responseModel;
      try {
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        if (response.statusCode == HttpStatus.ok) {
          var jsonString = await response.transform(Utf8Decoder()).join();
          var jsonResponse = json.decode(jsonString);
          var result = jsonResponse['result'];
          print(result);
          responseModel = ToutiaoResponseModel.fromJson(result);
        }
        else {
          print('response error');
        }
      }
      catch (exception) {
        print('exception');
      }
      isLoading = false;
      return responseModel;
    });
  }
}