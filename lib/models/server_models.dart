import 'package:english_teacher_app/domain/enum_difination.dart';

class UserSerModel {
  String id;
  String userName;
  String name;
  Sex sex;
  String school;
  DateTime birthday;
  Grade grade;
  String publisherId;
  UserSerModel(
      {this.id,
      this.userName,
      this.name,
      this.sex,
      this.school,
      this.birthday,
      this.grade,
      this.publisherId});

  factory UserSerModel.fromJson(Map<String, dynamic> json) {
    return UserSerModel(
      id: json["id"],
      name: json["name"],
      userName: json["userName"],
      school: json["school"],
      publisherId: json["publisherId"],
      birthday: DateTime.parse(json["birthday"]),
    );
  }
}

class GradeSerModel {
  int id;
  String name;
  GradeSerModel({this.id, this.name}) {}
  factory GradeSerModel.fromJson(Map<String, dynamic> json) {
    var model = new GradeSerModel(id: json["id"], name: json["name"]);
    return model;
  }
}

class SexSerModel {
  int id;
  String name;
  SexSerModel({this.id, this.name}) {}
  factory SexSerModel.fromJson(Map<String, dynamic> json) {
    var model = new SexSerModel(id: json["id"], name: json["name"]);
    return model;
  }
}

class PublisherSerModel {
  String id;
  String name;
  PublisherSerModel({this.id, this.name}) {}
  factory PublisherSerModel.fromJson(Map<String, dynamic> json) {
    var model = new PublisherSerModel(id: json["id"], name: json["title"]);
    return model;
  }
}

class PracticeLightSerModel {
  String id;
  DateTime time;
  double correctRate;
  int mins;
  int wordCount;
  PracticeLightSerModel(
      {this.id, this.time, this.wordCount, this.correctRate, this.mins});

  factory PracticeLightSerModel.fromJson(Map<String, dynamic> json) {
    var model = new PracticeLightSerModel(
        id: json["id"],
        correctRate: double.parse(json["correctRate"].toString()),
        wordCount: json["wordCount"],
        mins: json["mins"],
        time: DateTime.parse(json["time"]));
    return model;
  }
}

class WordPracticeSerModel {
  String english;
  String chinese;
  int errorCount;
  WordPracticeSerModel({this.english, this.chinese, this.errorCount});

  factory WordPracticeSerModel.fromJson(Map<String, dynamic> json) {
    var model = new WordPracticeSerModel(
        english: json["word"],
        chinese: json["chinese"],
        errorCount: json["errorCount"]);
    return model;
  }
}

class PracticeRichSerModel extends PracticeLightSerModel {
  List<WordPracticeSerModel> words;

  PracticeRichSerModel(
      {String id,
      DateTime time,
      int wordCount,
      double correctRate,
      int mins,
      this.words})
      : super(
            id: id,
            time: time,
            wordCount: wordCount,
            correctRate: correctRate,
            mins: mins);

  factory PracticeRichSerModel.fromJson(Map<String, dynamic> json) {
    var model = new PracticeRichSerModel(
        id: json["id"],
        correctRate: double.parse(json["correctRate"].toString()),
        wordCount: json["wordCount"],
        mins: json["mins"],
        time: DateTime.parse(json["time"]));
    if (json["words"] != null) {
      var ws = json["words"] as List;
      model.words = ws.map((e) => WordPracticeSerModel.fromJson(e)).toList();
    }

    return model;
  }
}

class PracticeArticleSerMoel {
  String id;
  List<String> words = [];
  PracticeArticleSerMoel({this.id, this.words});

  factory PracticeArticleSerMoel.fromJson(Map<String, dynamic> json) {
    var model = new PracticeArticleSerMoel(id: json["id"]);
    if (json["words"] != null) {
      var ws = json["words"] as List;
      model.words = new List<String>();
      for (var w in ws) {
        model.words.add(w);
      }
    }
    return model;
  }
}

class PracticeSumSerModel {
  int minutes = 0;
  int wordCount = 0;
  int practiceCount =0;
  double lastPracticeCorrectRate =0;
  PracticeSumSerModel(
      {this.minutes,
      this.wordCount,
      this.practiceCount,
      this.lastPracticeCorrectRate});
  factory PracticeSumSerModel.fromJson(Map<String, dynamic> json) {
    var model = new PracticeSumSerModel(
        minutes: json["minutes"],
        wordCount: json["wordCount"],
        practiceCount: json["practiceCount"],
        lastPracticeCorrectRate: json["lastPracticeCorrectRate"]);
    return model;
  }
}

class TextSerModel {
  String title;
  List<SentenceSerModel> body;
  TextSerModel({this.title, this.body});
  factory TextSerModel.fromJson(Map<String, dynamic> json) {
    var model = new TextSerModel(title: json["title"]);
    if (json["body"] != null) {
      var ws = json["body"] as List;
      model.body = ws.map((e) => SentenceSerModel.fromJson(e)).toList();
    }
    return model;
  }
}

class SentenceSerModel {
  String chinese;
  String english;
  SentenceType sentenceType;
  SentenceSerModel({this.chinese, this.english, this.sentenceType});
  factory SentenceSerModel.fromJson(Map<String, dynamic> json) {
    var model = new SentenceSerModel(
        chinese: json["chinese"],
        english: json["english"],
        sentenceType: json["sentenceType"] == 0
            ? SentenceType.PracticeSentence
            : SentenceType.UnPracticeSentence);
    return model;
  }
}

class WordSerModel {
  String english;
  String chinese;
  String symbol;
  List<WordSerPart> parts;
  WordSerModel({this.english, this.chinese, this.symbol, this.parts});

  factory WordSerModel.fromJson(Map<String, dynamic> json) {
    var model =
        new WordSerModel(chinese: json["chinese"], english: json["english"]);
    if (json["parts"] != null) {
      var ws = json["parts"] as List;
      model.parts = ws.map((e) => WordSerPart.fromJson(e)).toList();
    }
    return model;
  }
}

class WordSerPart {
  String chinese;
  String english;
  WordSerPart({this.chinese, this.english});

  factory WordSerPart.fromJson(Map<String, dynamic> json) {
    var model = new WordSerPart(
      chinese: json["chinese"],
      english: json["english"],
    );
    return model;
  }
}

class WechatSettings {
  String appId;
  String universalLink;
  WechatSettings({this.appId, this.universalLink});
  factory WechatSettings.fromJson(Map<String, dynamic> json) {
    var model = new WechatSettings(
        appId: json["appId"], universalLink: json["universalLink"]);
    return model;
  }
}
