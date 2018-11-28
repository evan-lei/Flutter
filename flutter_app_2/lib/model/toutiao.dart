
class ToutiaoModel{
  String uniquekey;
  String title;
  String date;
  String category;
  String author_name;
  String url;
  String thumbnail_pic_s;
  String thumbnail_pic_s02;
  String thumbnail_pic_s03;

  ToutiaoModel({
    this.uniquekey,
    this.title,
    this.date,
    this.category,
    this.author_name,
    this.url,
    this.thumbnail_pic_s,
    this.thumbnail_pic_s02,
    this.thumbnail_pic_s03
  });

  factory ToutiaoModel.fromJson(Map<String, dynamic> parsedJson){
    return ToutiaoModel(
      uniquekey:parsedJson['uniquekey'],
      title:parsedJson['title'],
      date:parsedJson['date'],
      category:parsedJson['category'],
      author_name:parsedJson['author_name'],
      url:parsedJson['url'],
      thumbnail_pic_s:parsedJson['thumbnail_pic_s'],
      thumbnail_pic_s02:parsedJson['thumbnail_pic_s02'],
      thumbnail_pic_s03:parsedJson['thumbnail_pic_s03']
    );
  }

}

class ToutiaoResponseModel {
  String stat;
  List<ToutiaoModel> data;

  ToutiaoResponseModel({
    this.stat,
    this.data,
  });

  factory ToutiaoResponseModel.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['data'] as List;
    List<ToutiaoModel> dataList = list.map((i) => ToutiaoModel.fromJson(i)).toList();
    return ToutiaoResponseModel(
        stat:parsedJson['stat'],
        data:dataList,
    );
  }
}
