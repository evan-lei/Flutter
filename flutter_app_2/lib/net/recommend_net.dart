import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_app_2/model/toutiao.dart';

class RecommendNet{
  bool isLoading = false;

  Future<ToutiaoResponseModel> getData(bool isFresh, String type) async {

    if (isLoading) {
      return new Future<ToutiaoResponseModel>((){
        return null;
      });
    }

    return new Future<ToutiaoResponseModel>(() async{

      isLoading = true;
      ToutiaoResponseModel responseModel;
      var url = 'http://v.juhe.cn/toutiao/index?type='+type+'&key=aa4e398ed507e49248714b7ff097e93e';

      // 使用第三方库Dio请求数据
      Dio dio = new Dio();
      try {
        Response response =  await dio.get(url);
        if (response.statusCode == HttpStatus.ok) {
          var result = response.data['result'];
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

/* 使用HttpClient请求数据
      var httpClient = new HttpClient();
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
*/
      isLoading = false;
      return responseModel;
    });
  }
}