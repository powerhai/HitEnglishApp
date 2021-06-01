import 'dart:async'; 
import 'package:english_teacher_app/helpers/text_translator.dart';
import 'package:english_teacher_app/models/client_model.dart';
import 'package:english_teacher_app/models/word.dart';
import 'package:english_teacher_app/services/article_service.dart';
import 'package:english_teacher_app/services/practice_service.dart';
import 'package:english_teacher_app/services/word_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class VmTypeWords extends ChangeNotifier {
  PracticeService practiceService;
  ArticleService articleService;
  WordService wordService;
  List<UiArticle> practiceArticles = [];
  List<UiWord> words = [];
  List<UiWord> praticeWords = [];
  int currentWordIndex = -1;
  UiWord currentWord;
  UiArticle currentArticle;
  String _inputText = "";
  double _fontSize = 22.0;
  final maxFontSize = 70.0;
  final minFontSize = 12.0;
  DateTime startTime;
  Duration praticeTimes = new Duration();
  void Function(String wordEnglish) focusWord;
  void Function() complated;
  void Function() playWordAnimation;
  void Function() hideWordPartBoard;
  String get inputText => _inputText;
  set inputText(String value) => _inputText = value;

  double get fontSize => _fontSize;
  set fontSize(double value) => _fontSize = value;

  double get correctRate {
    var errorCount = this.words.where((a) => a.error == false).length;
    var rate = errorCount / this.words.length * 100;
    return rate;
  }

  VmTypeWords(this.focusWord, this.complated, this.playWordAnimation,
      this.hideWordPartBoard) {
    startTime = DateTime.now();
    heartbeat();
  }

  void heartbeat() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      praticeTimes = DateTime.now().difference(startTime);
      this.notifyListeners();
    });
  }

  void onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) return;

    if (event.logicalKey.keyId >= 32 && event.logicalKey.keyId <= 126) {
      var char = String.fromCharCode(event.logicalKey.keyId);
      this.inputText += char;
      notifyListeners();
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      if (this.inputText.length <= 0) return;

      this.inputText = this.inputText.substring(0, this.inputText.length - 1);
      notifyListeners();
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (currentWord.english.toLowerCase() == this.inputText.toLowerCase()) {
        answerRight();
      } else {
        answerError();
      }
      this.inputText = "";
      notifyListeners();
    }
  }

  void answerRight() {
    hideWordPartBoard();
    var rv = moveToNextWord();
    if (rv == false) {
      savePracticeInfo();
      this.complated();
    }
  }

  //记录练习情况
  void savePracticeInfo() {
    this.practiceService.savePractice(
        DateTime.now().difference(startTime),
        this.correctRate,
        words
            .map((e) => new WordPostModel(
                english: e.english, chinese: e.chinese, isError: e.error))
            .toList());
  }

  void answerError() {
    this.currentWord.error = true;
    var noPraticeWords =
        this.praticeWords.skip(this.currentWordIndex + 1).toList();
    if (!noPraticeWords.any((e) => e.english == this.currentWord.english)) {
      this.praticeWords.add(this.currentWord);
    }
    this.playWordAnimation();
  }

  void zoomTo(double value) {
    if (value > maxFontSize || value < minFontSize) return;
    fontSize = value;
    notifyListeners();
  }

  void zoomIn() {
    zoomTo(fontSize += 2.0);
  }

  void zoomOut() {
    zoomTo(fontSize -= 2.0);
  }

  Future<AsyncSnapshot<bool>> init() async {
    practiceService = await GetIt.instance.getAsync<PracticeService>();
    articleService = await GetIt.instance.getAsync<ArticleService>();
    wordService = await GetIt.instance.getAsync<WordService>();

    //获取练习
    var articlesA = await practiceService.getPracticeArticles();
    var wordStrings = List<String>();
    var artIds = List<String>();
    for (var a in articlesA) {
      wordStrings.addAll(a.words);
      artIds.add(a.id);
    }
    //获文章

    for (var textId in artIds) {
      var art = await this.articleService.getArticle(textId);
      var act = articlesA.firstWhere((e) => e.id == textId);
      var tr = new TextTranslator2(praticeWords: act.words);
      UiArticle u = new UiArticle(id: textId, title: art.title);
      u.paragraphs = tr.computeParagraphs(art.body);
      practiceArticles.add(u);
    }

/*
    var articlesB = await articleService.getArticles(artIds);
    for (var b in articlesB) {
      var act = articlesA.firstWhere((e) => e.id == b.id);
      //var ws = words.where((w) => act.words.contains(w.english));
      var tr = new TextTranslator(praticeWords: act.words);
      UiArticle u = new UiArticle(id: b.id, title: b.title);
      u.paragraphs = tr.computeParagraphs(b.body);
      practiceArticles.add(u);
    }
*/
    //获取单词
    //var ws = await wordService.getWords(wordStrings);
    for (var w in wordStrings) {
      var word = await wordService.getWord(w);
      var actId =
          articlesA.firstWhere((e) => e.words.contains(word.english)).id;
      var act = practiceArticles.firstWhere((e) => e.id == actId);

      UiWord wd = new UiWord(
          acticle: act,
          word: new Word(
              english: word.english,
              chinese: word.chinese,
              symbol: "[e]",
              parts: word.parts.map((e) => new WordPart()).toList()));
      words.add(wd);
    }

    praticeWords = words.toList();
    moveToFirstWord();
    await Future.delayed(Duration(milliseconds: 100));
    return new AsyncSnapshot<bool>.withData(ConnectionState.done, true);
  }

  void moveToFirstWord() {
    currentWordIndex = 0;
    currentWord = praticeWords[currentWordIndex];
    currentArticle = currentWord.acticle;
    this.notifyListeners();
  }

  bool moveToNextWord() {
    currentWordIndex += 1;
    if (currentWordIndex >= praticeWords.length) {
      return false;
    }

    currentWord = praticeWords[currentWordIndex];
    currentArticle = currentWord.acticle;
    this.notifyListeners();
    this.focusWord(currentWord.english);
    return true;
  }

  UiWord getWord(String english) {
    return words.firstWhere((e) => e.english == english);
  }
}
