// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartOfWord _$PartOfWordFromJson(Map<String, dynamic> json) {
  return PartOfWord()
    ..english = json['English'] as String
    ..chinese = json['Chinese'] as String;
}

Map<String, dynamic> _$PartOfWordToJson(PartOfWord instance) =>
    <String, dynamic>{'English': instance.english, 'Chinese': instance.chinese};

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
      english: json['English'] as String,
      chinese: json['Chinese'] as String,
      symbol: json['Symbol'] as String)
    ..parts = (json['Parts'] as List)
        ?.map((e) =>
            e == null ? null : PartOfWord.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..error = json['error'] as bool
    ..errorCount = json['errorCount'] as int
    ..sentence = json['sentence'] == null
        ? null
        : Sentence.fromJson(json['sentence'] as Map<String, dynamic>)
    ..article = json['article'] == null
        ? null
        : Article.fromJson(json['article'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'English': instance.english,
      'Chinese': instance.chinese,
      'Symbol': instance.symbol,
      'Parts': instance.parts,
      'error': instance.error,
      'errorCount': instance.errorCount,
      'sentence': instance.sentence,
      'article': instance.article
    };
 
Sentence _$SentenceFromJson(Map<String, dynamic> json) {
  return Sentence(
      id: json['ID'] as String,
      english: json['English'] as String,
      chinese: json['Chinese'] as String)
    ..audioLocalPath = json['audioLocalPath'] as String
    ..audioUrl = json['AudioUrl'] as String
    ..words = (json['Words'] as List)
        ?.map(
            (e) => e == null ? null : Word.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SentenceToJson(Sentence instance) => <String, dynamic>{
      'ID': instance.id,
      'English': instance.english,
      'Chinese': instance.chinese,
      'audioLocalPath': instance.audioLocalPath,
      'AudioUrl': instance.audioUrl,
      'Words': instance.words
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(id: json['ID'] as String, title: json['Title'] as String)
    ..sentences = (json['Sentences'] as List)
        ?.map((e) =>
            e == null ? null : Sentence.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'ID': instance.id,
      'Title': instance.title,
      'Sentences': instance.sentences
    };

Practice _$PracticeFromJson(Map<String, dynamic> json) {
  return Practice()
    ..articles = (json['Articles'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PracticeToJson(Practice instance) =>
    <String, dynamic>{'Articles': instance.articles};
