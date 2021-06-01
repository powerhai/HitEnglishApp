class WordPostModel {
  String english;
  String chinese;
  bool isError;
  WordPostModel({this.english, this.chinese, this.isError});

  
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english'] = this.english;
    data['chinese'] = this.chinese;
    data["isError"]  = this.isError;
    return data;
  }  
}

 