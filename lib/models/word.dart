 
 
import 'package:english_teacher_app/helpers/text_translator.dart';



class Word {
  String english;
  String chinese;
  String symbol;
  List<WordPart> parts;
  Word({this.english, this.chinese, this.symbol, this.parts});
}

class WordPart {
  String chinese;
  String english;
  WordPart({this.chinese, this.english});
}



class UiArticle {
  String id;
  String title;
  List<FeParagraph> paragraphs = [];
  List<Word> words = [];
  UiArticle({this.id, this.title});
}


class UiWord extends Word {
  UiArticle acticle;
  bool _error = false;
  bool get error => _error;
  set error(bool value) => _error = value;

  UiWord({this.acticle, Word word})
      : super(
            english: word.english,
            chinese: word.chinese,
            symbol: word.symbol,
            parts: word.parts);
}

