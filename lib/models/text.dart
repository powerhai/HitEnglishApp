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
      var s1 = new Sentence(english: "I have a storybook.", chinese: "?????????????????????");
      s1.words.add(new Word(english: "have", chinese: "???"));
      s1.words.add(new Word(english: "storybook", chinese: "?????????"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(english: "Look at that room.", chinese: "?????????????????????");
      s1.words.add(new Word(english: "Look", chinese: "???"));
      s1.words.add(new Word(english: "that", chinese: "?????????"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(
          english:
              "Base on your comments, I designed two drafts see below, which one is more appropriate? ",
          chinese: "???????????????????????????????????????????????????");
      s1.words.add(new Word(english: "on", chinese: "???????????????"));
      a1.sentences.add(s1);
    }

    p.articles.add(a1);
  }

  {
    var a1 = new Article(title: "My living room");

    {
      var s1 = new Sentence(english: "I love you", chinese: "????????????");
      s1.words.add(new Word(english: "love", chinese: "???"));
      a1.sentences.add(s1);
    }

    {
      var s1 = new Sentence(
          english:
              "A more experience user will prefer the Connection screen since it is easier and quicker. ",
          chinese: "?????????????????????????????????");
      s1.words.add(new Word(english: "will", chinese: "???"));
      s1.words.add(new Word(english: "quicker", chinese: "?????????"));

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
                    "Chinese": "???????????????????????????", 
                    "Words": [
                        {
                            "English": "is", 
                            "Chinese": "???",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "??????"},
                            {
                              "English": "par", 
                            "Chinese": "??????"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "??????.."
                            }
                              
                            ]
                        }, 
                        {
                            "English": "of", 
                            "Chinese": "???",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "??????"},
                            {
                              "English": "par", 
                            "Chinese": "??????"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "??????.."
                            }
                              
                            ]
                        }, 
                        {
                            "English": "the", 
                            "Chinese": "?????????",
                            "Parts" : [
                              { "English": "com", 
                            "Chinese": "??????"},
                            {
                              "English": "par", 
                            "Chinese": "??????"
                            },
                            {
                              "English": "ing", 
                            "Chinese": "??????.."
                            }
                              
                            ]
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "Located on the east coast, it is best known for the White House, where the PresIDent of the US lives and works,", 
                    "Chinese": "??????????????????????????????", 
                    "Words": [
                        {
                            "English": "east", 
                            "Chinese": "??????"
                        }, 
                        {
                            "English": "White", 
                            "Chinese": "?????????"
                        }, 
                        {
                            "English": "lives", 
                            "Chinese": "??????"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "and for Capitol Hill, where the US Congress meets.", 
                    "Chinese": "?????????????????????", 
                    "Words": [
                        {
                            "English": "Hill", 
                            "Chinese": "??????"
                        }, 
                        {
                            "English": "where", 
                            "Chinese": "??????"
                        }, 
                        {
                            "English": "meets", 
                            "Chinese": "??????"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "There are many famous monuments, memorials and museums in Washington DC. ", 
                    "Chinese": "???????????????????????????", 
                    "Words": [
                        {
                            "English": "many", 
                            "Chinese": "??????"
                        }, 
                        {
                            "English": "museums", 
                            "Chinese": "?????????"
                        }, 
                        {
                            "English": "in", 
                            "Chinese": "??????"
                        }
                    ]
                }, 
                {
                    "ID": "232", 
                    "English": "The Lincoln Memorial is a grand white building.", 
                    "Chinese": "???????????????????????????", 
                    "Words": [
                        {
                            "English": "a", 
                            "Chinese": "??????"
                        }, 
                        {
                            "English": "building", 
                            "Chinese": "??????"
                        }
                    ]
                }
            ]
        }
    ]
}
""";
