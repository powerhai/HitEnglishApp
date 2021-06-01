import 'package:english_teacher_app/domain/enum_difination.dart';
import 'package:english_teacher_app/models/server_models.dart';

class FeParagraph {
  List<FeText> texts = [];
}

class FeText {
  String english = "";
  int start;
  int end;
  FeText(this.english, this.start, this.end);
}

class FeSentence extends FeText {
  String chinese = "";
  double audioStart = 0;
  double audioEnd = 0;
  List<FeText> texts = [];
  FeSentence(String english, int start, int end, {this.chinese})
      : super(english, start, end);
}

class FeWord extends FeText {
  FeWord(String english, int start, int end) : super(english, start, end);
}

class TextTranslator2 {
  RegExp wordReg = new RegExp("[a-zA-Z']+");

  List<String> practiceWords = [];
  TextTranslator2({List<String> praticeWords}) {
    this.practiceWords = praticeWords.toList();
  }
  List<FeParagraph> computeParagraphs(List<SentenceSerModel> sentences) {
    var pars = new List<FeParagraph>();
    for (var sen in sentences) {
      var par = computeParagraph(sen);
      if (par != null) {
        pars.add(par);
      }
    }
    return pars;
  }

  FeParagraph computeParagraph(SentenceSerModel sentence) {
    FeParagraph par = new FeParagraph();
    if (sentence.sentenceType == SentenceType.UnPracticeSentence) {
      par.texts.add(new FeText(sentence.english, 0, sentence.english.length));
    } else {
      var cen = FeSentence(sentence.english, 0, 0, chinese: sentence.chinese);
      computeSentenceTests(cen);
      par.texts.add(cen);
    }
    return par;
  }

  //获取句子中的单词列表
  List<FeWord> getWords(String sentence) {
    List<FeWord> ws = [];
    var mts = wordReg.allMatches(sentence);
    for (var mt in mts) {
      var word = FeWord(mt.group(0), mt.start, mt.end);
      ws.add(word);
    }
    return ws;
  }

  //从一组单词中获取要练习的单词列表
  List<FeWord> getPracticeWords(List<FeWord> words) {
    if (this.practiceWords.length <= 0) return [];
    return words.where((w) => this.practiceWords.contains(w.english)).toList();
  }

  void computeSentenceTests(FeSentence sen) {
    var words = this.getWords(sen.english);
    var pwords = this.getPracticeWords(words);
    if (pwords.length == 0) {
      sen.texts.add(FeText(sen.english, 0, sen.english.length));
      return;
    }

    int last = 0;
    for (var w in pwords) {
      if (last != w.start) {
        var t = FeText(sen.english.substring(last, w.start), last, w.start);
        sen.texts.add(t);
      }
      {
        var wd = FeWord(w.english, w.start, w.end);
        sen.texts.add(wd);
        this.practiceWords.remove(w.english);
      }
      last = w.start + w.english.length;
    }
    if (last < sen.english.length) {
      var t = FeText(sen.english.substring(last), last, sen.english.length);
      sen.texts.add(t);
    }
  }
}
 