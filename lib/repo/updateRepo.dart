import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/Screens/task.dart';

class UpdateRepo{
  Future <void> updatePage(
    String id,
    String taskname,
    String description,
  )async
  {
    final CollectionReference update = FirebaseFirestore.instance.collection('taskCollection');
    try{
      await update.doc('task').update({
        'taskname': taskname,
        'decription': description,
      });
      
      print('task updated');
    }
    catch(e){
      print('cannot updated');
      throw Exception();
      
    }
  }
}