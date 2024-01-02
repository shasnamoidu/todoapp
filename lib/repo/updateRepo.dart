import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/Screens/task.dart';

class UpdateRepo{
  Future <bool> updatetask(
    String id,
    String taskupd,
    String descriptionupd,
  )async
  {
    final CollectionReference update = FirebaseFirestore.instance.collection('taskCollection');
    
    final DocumentSnapshot doc = await update.doc(id).get();
    

if (doc.exists) {
    // Document exists, proceed with the update
    await update.doc(id).update({
        'task': taskupd,
        'description': descriptionupd,
    });
    print('Task updated');
    return true;
} else {
    // Document does not exist
    print('Document with ID $id not found');
    return false;
}
    try{
      print(id);
      print(taskupd);
      print(descriptionupd);
      await update.doc(id).update({
        'task': taskupd,
        'description': descriptionupd,
      });
      return true;
      print('task updated');
    }
    catch(e){
      print('cannot updated');
      rethrow;
      
    }
  }
}