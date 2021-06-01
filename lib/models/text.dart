import 'package:json_annotation/json_annotation.dart';
 
part 'text.g.dart';

@JsonSerializable()
class PartOfWord {
  @JsonKey(name: 'English')
  String english;
  @JsonKey(name: 'Chinese')
  String chinese;
PartOfWord({this.english, this.chinese});
  factory PartOfWord.fromJson(Map<String, dynamic> json) =>
      _$PartOfWordFromJson(json);
}
 
@JsonSerializable()
class Word {
  @JsonKey(name: 'English')
  String english;
  @JsonKey(name: 'Chinese')
  String chinese;
  @JsonKey(name: 'Symbol')
  String symbol;
  Word({this.english, this.chinese, this.symbol});
  @JsonKey(name: 'Parts')
  List<PartOfWord> parts = new List<PartOfWord>();
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  String toJsonString() {
    return _$WordToJson(this).toString();
  }

  bool error = false;
  int errorCount = 0;

  Sentence sentence;
  Article article;
}

@JsonSerializable()
class Sentence {
  @JsonKey(name: 'ID')
  String id;
  @JsonKey(name: 'English')
  String english;
  @JsonKey(name: 'Chinese')
  String chinese;
  String audioLocalPath;
  @JsonKey(name: 'AudioUrl')
  String audioUrl;
  Sentence({this.id, this.english, this.chinese});
  factory Sentence.fromJson(Map<String, dynamic> json) =>
      _$SentenceFromJson(json);

  @JsonKey(name: 'Words')
  List<Word> words = new List<Word>();
  Word getWord(String word) {
    return words.firstWhere((t) {
      return t.english == word;
    }, orElse: () {
      return null;
    });
  }
}

@JsonSerializable()
class Article {
  @JsonKey(name: 'ID')
  String id;
  @JsonKey(name: 'Title')
  String title;
  Article({this.id, this.title});
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  @JsonKey(name: 'Sentences')
  List<Sentence> sentences = new List<Sentence>();
}

@JsonSerializable()
class Practice {
  @JsonKey(name: 'Articles')
  List<Article> articles = new List<Article>();
  Practice();
  factory Practice.fromJson(Map<String, dynamic> json) =>
      _$PracticeFromJson(json);
  String toJsonString() {
    return _$PracticeToJson(this).toString();
  }
}

Practice getPractice() {
  var p = new Practice();
  {
    var a1 = new Article(title: "Our school day");

    {
      var s1 = new Sentence(english: "I have a storybook.", chinese: "我有一本英语书");
      s1.words.add(new Word(english: "have", chinese: "有"));
      s1.words.add(new Word(english: "storybook", chinese: "故事书"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(english: "Look at that room.", chinese: "我有一本英语书");
      s1.words.add(new Word(english: "Look", chinese: "有"));
      s1.words.add(new Word(english: "that", chinese: "故事书"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(
          english:
              "Base on your comments, I designed two drafts see below, which one is more appropriate? ",
          chinese: "基于你的提醒，我做了两个设计草图。");
      s1.words.add(new Word(english: "on", chinese: "在。。。里"));
      a1.sentences.add(s1);
    }

    p.articles.add(a1);
  }

  {
    var a1 = new Article(title: "My living room");

    {
      var s1 = new Sentence(english: "I love you", chinese: "我喜欢你");
      s1.words.add(new Word(english: "love", chinese: "爱"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(
          english:
              "A more experience user will prefer the Connection screen since it is easier and quicker. ",
          chinese: "我这里有一个更好的方案");
      s1.words.add(new Word(english: "will", chinese: "会"));
      s1.words.add(new Word(english: "quicker", chinese: "快速的"));

      a1.sentences.add(s1);
    }

    p.articles.add(a1);
  }

  String js = p.toJsonString();
  print(js);
  return p;
}

String jsonData = """
{
    "Articles": [
        {
            "ID": "123", 
            "Title": "I love this song.", 
            "Sentences": [
                {
                    "ID": "232", 
                    "English": "Washington DC  is the capital of the US. ", 
                    "Chinese": "华盛顿是美国的首都", 
                    "Words": [
                        {
                            "English": "is", 
                            "Chinese": "是",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "公司"},
                            {
                              "English": "par", 
                            "Chinese": "之前"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "正在.."
                            }
                              
                            ]
                        }, 
                        {
                            "English": "of", 
                            "Chinese": "的",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "公司"},
                            {
                              "English": "par", 
                            "Chinese": "之前"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "正在.."
                            }
                              
                            ]
                        }, 
                        {
                            "English": "the", 
                            "Chinese": "定冠词",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "公司"},
                            {
                              "English": "par", 
                            "Chinese": "之前"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "正在.."
                            }
                              
                            ]
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "Located on the east coast, it is best known for the White House, where the PresIDent of the US lives and works,", 
                    "Chinese": "它坐落于美国的东海岸", 
                    "Words": [
                        {
                            "English": "east", 
                            "Chinese": "东部"
                        }, 
                        {
                            "English": "White", 
                            "Chinese": "白色的"
                        }, 
                        {
                            "English": "lives", 
                            "Chinese": "生活"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "and for Capitol Hill, where the US Congress meets.", 
                    "Chinese": "美国总统是白痴", 
                    "Words": [
                        {
                            "English": "Hill", 
                            "Chinese": "山庄"
                        }, 
                        {
                            "English": "where", 
                            "Chinese": "哪里"
                        }, 
                        {
                            "English": "meets", 
                            "Chinese": "居住"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "There are many famous monuments, memorials and museums in Washington DC. ", 
                    "Chinese": "这里有很多的博物馆", 
                    "Words": [
                        {
                            "English": "many", 
                            "Chinese": "很多"
                        }, 
                        {
                            "English": "museums", 
                            "Chinese": "博物馆"
                        }, 
                        {
                            "English": "in", 
                            "Chinese": "里面"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "The Lincoln Memorial is a grand white building.", 
                    "Chinese": "林肯博物馆就在这里", 
                    "Words": [
                        {
                            "English": "a", 
                            "Chinese": "一个"
                        }, 
                        {
                            "English": "building", 
                            "Chinese": "建筑"
                        }
                    ]
                }
            ]
        }
    ]
}
""";
