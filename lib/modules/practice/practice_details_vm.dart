import 'package:english_teacher_app/models/practice.dart';
import 'package:english_teacher_app/models/server_models.dart';
import 'package:english_teacher_app/models/word.dart';
import 'package:english_teacher_app/services/practice_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class VmPracticeDetails extends ChangeNotifier {
  PracticeService practiceService;

  String practiceId;
  VmPracticeDetails(this.practiceId) {
   
  }
  PracticeRichSerModel practiceData;


  Future<AsyncSnapshot<bool>> init() async {
     practiceService = await GetIt.instance.getAsync<PracticeService>();
    practiceData = await practiceService.getPractice(practiceId);
        practiceData.words.sort((a, b) => b.errorCount - a.errorCount);
    return new AsyncSnapshot<bool>.withData(ConnectionState.done, true);
  }
}
